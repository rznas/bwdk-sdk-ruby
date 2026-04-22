# OpenapiClient::ShippingMethod

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** |  | [readonly] |
| **name** | **String** | نام روش/گزینه بسته‌بندی |  |
| **description** | **String** | شناسه روش ارسال برای استفاده در سفارش | [optional] |
| **shipping_type** | [**ShippingTypeEnum**](ShippingTypeEnum.md) | شناسه وضعیت ارسال از دیجی اکسپرس  * &#x60;1&#x60; - سایر * &#x60;2&#x60; - دیجی اکسپرس | [optional] |
| **get_shipping_type_display** | **String** |  | [readonly] |
| **shipping_type_display** | **String** |  | [readonly] |
| **cost** | **Integer** | هزینه ارسال برای منطقه اصلی (مثلاً تهران) به تومان | [optional] |
| **secondary_cost** | **Integer** | هزینه ارسال برای مناطق دیگر به تومان | [optional] |
| **minimum_time_sending** | **Integer** | حداقل تعداد روز از تاریخ سفارش تا تحویل | [optional] |
| **maximum_time_sending** | **Integer** | Maximum number of days from order date to delivery | [optional] |
| **delivery_time_display** | **String** |  | [readonly] |
| **delivery_time_range_display** | [**DeliveryTimeRangeDisplay**](DeliveryTimeRangeDisplay.md) |  | [readonly] |
| **inventory_address** | [**BusinessAddress**](BusinessAddress.md) |  | [readonly] |
| **is_pay_at_destination** | **Boolean** | آیا روش ارسال پرداخت در مقصد است | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::ShippingMethod.new(
  id: null,
  name: null,
  description: null,
  shipping_type: null,
  get_shipping_type_display: null,
  shipping_type_display: null,
  cost: null,
  secondary_cost: null,
  minimum_time_sending: null,
  maximum_time_sending: null,
  delivery_time_display: null,
  delivery_time_range_display: null,
  inventory_address: null,
  is_pay_at_destination: null
)
```

