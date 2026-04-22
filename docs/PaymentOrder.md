# OpenapiClient::PaymentOrder

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **final_amount** | **Integer** |  | [readonly] |
| **gateway_type** | [**GatewayTypeEnum**](GatewayTypeEnum.md) |  | [readonly] |
| **gateway_type_display** | **String** |  | [readonly] |
| **paid_at** | **String** |  | [readonly] |
| **gateway_name** | **String** |  | [readonly] |
| **invoice_id** | **String** |  | [readonly] |
| **settlement_date** | **String** |  | [readonly] |
| **settlement_status** | **Integer** |  | [readonly] |
| **settlement_status_display** | **String** |  | [readonly] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::PaymentOrder.new(
  final_amount: null,
  gateway_type: null,
  gateway_type_display: null,
  paid_at: null,
  gateway_name: null,
  invoice_id: null,
  settlement_date: null,
  settlement_status: null,
  settlement_status_display: null
)
```

