# OpenapiClient::WalletBalance

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **amount** | **Integer** | موجودی کیف پول فعلی (برحسب تومان) | [optional] |
| **negative_settlement_deadline** | **String** | مهلت تسویه تراز منفی | [readonly] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::WalletBalance.new(
  amount: null,
  negative_settlement_deadline: null
)
```

