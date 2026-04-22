# OpenapiClient::MerchantOrderRefundResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message** | **String** |  |  |
| **order_uuid** | **String** |  |  |
| **status** | [**OrderStatusEnum**](OrderStatusEnum.md) |  |  |
| **status_display** | **String** |  |  |
| **refund_reason** | **String** |  |  |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::MerchantOrderRefundResponse.new(
  message: null,
  order_uuid: null,
  status: null,
  status_display: null,
  refund_reason: null
)
```

