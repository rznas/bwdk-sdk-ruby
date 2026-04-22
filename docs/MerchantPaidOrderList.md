# OpenapiClient::MerchantPaidOrderList

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_uuid** | **String** |  | [readonly] |
| **merchant_order_id** | **String** | شناسه منحصر به فرد سفارش در سیستم فروشنده | [readonly] |
| **merchant_unique_id** | **String** | شناسه منحصر به فرد برای پذیرنده برای تأیید سفارش | [readonly] |
| **paid_at** | **Time** |  | [readonly] |
| **refunds_at** | **Time** |  | [readonly] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::MerchantPaidOrderList.new(
  order_uuid: null,
  merchant_order_id: null,
  merchant_unique_id: null,
  paid_at: null,
  refunds_at: null
)
```

