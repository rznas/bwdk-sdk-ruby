# BWDK Ruby SDK — Integration Guide for Agents

You are integrating **BWDK (Buy With DigiKala)** into a Ruby project (Rails / Sinatra / Hanami / Roda) via this SDK. Read this file **first**, then consult the companion references below.

## BWDK constants

- **Host:** `https://bwdk-backend.digify.shop`
- **Auth scheme:** `MerchantAPIKeyAuth` — header `Authorization: <api_key>`.
- **Main API class:** `OpenapiClient::DefaultApi`.
- **Gem name:** `openapi_client`.

## Companion references

| File                 | When to read                                                  |
|----------------------|---------------------------------------------------------------|
| `README.md`          | `gem build` / `gem install` / Gemfile wiring and "Getting Started" example. Follow it verbatim. |
| `FLOWCHART.md`       | Canonical order state machine. All callback/webhook branching MUST match these state names. |
| `docs/DefaultApi.md` | Exact method names and signatures per endpoint.               |
| `docs/*.md`          | Per-model reference (e.g. `docs/OrderCreate.md`).             |

Do **not** duplicate install or method-signature details here — fetch `README.md`.

## Minimal wrapper pattern

```ruby
require 'openapi_client'

OpenapiClient.configure do |config|
  config.host       = 'bwdk-backend.digify.shop'
  config.scheme     = 'https'
  config.api_key['Authorization'] = ENV.fetch('BWDK_API_KEY')
end

api = OpenapiClient::DefaultApi.new
order = api.order_api_v1_create_order_create(payload)
```

Method names are snake_case and OpenAPI-generated (e.g. `order_api_v1_create_order_create`, `order_api_v1_manager_verify_create`). Look them up in `docs/DefaultApi.md`; do **not** guess.

## Integration invariants

1. **SDK only.** Never call BWDK with `Net::HTTP`, `Faraday`, `HTTParty`, `RestClient`, or `Typhoeus`.
2. **Callback flow.** After payment, BWDK redirects the customer to your `callback_url`. Load the order (`order_api_v1_manager_retrieve`), branch on `order.status` per `FLOWCHART.md`, then call `order_api_v1_manager_verify_create` — `verify` is mandatory before `SHIPPED`.
3. **Errors.** Rescue `OpenapiClient::ApiError`; inspect `.code` (HTTP status) and `.response_body`. Retry only on transport errors, never on 4xx.
4. **Pinning.** Pin a concrete version in `Gemfile` (`gem 'openapi_client', '1.2.3'`), matching a `vX.Y.Z` tag.

## Project conventions

- **Rails:** wrap calls in a service object under `app/services/bwdk/`; do not call `OpenapiClient::DefaultApi.new` from controllers.
- **Configuration:** call `OpenapiClient.configure` once at boot (`config/initializers/bwdk.rb`) — not per request.
- **Background jobs:** `order_api_v1_manager_verify_create` and shipping-status updates are network-bound — run them in Sidekiq / GoodJob, not in the request cycle.
