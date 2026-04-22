# OpenapiClient::ShippingMethod

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** |  | [readonly] |
| **name** | **String** | نام روش ارسال |  |
| **description** | **String** | توضیحات روش ارسال و جزئیات تحویل آن | [optional] |
| **shipping_type** | [**ShippingTypeEnum**](ShippingTypeEnum.md) | نوع روش ارسال: عادی یا دیجی اکسپرس  * &#x60;1&#x60; - سایر * &#x60;2&#x60; - دیجی اکسپرس | [optional] |
| **get_shipping_type_display** | **String** |  | [readonly] |
| **shipping_type_display** | **String** |  | [readonly] |
| **cost** | **Integer** | هزینه ارسال برای منطقه اولیه (مثلاً تهران) به تومان | [optional] |
| **secondary_cost** | **Integer** | هزینه ارسال برای مناطق دیگر به تومان | [optional] |
| **minimum_time_sending** | **Integer** | حداقل تعداد روزها از تاریخ سفارش تا تحویل | [optional] |
| **maximum_time_sending** | **Integer** | حداکثر تعداد روزها از تاریخ سفارش تا تحویل | [optional] |
| **delivery_time_display** | **String** |  | [readonly] |
| **delivery_time_range_display** | [**DeliveryTimeRangeDisplay**](DeliveryTimeRangeDisplay.md) |  | [readonly] |
| **inventory_address** | [**BusinessAddress**](BusinessAddress.md) |  | [readonly] |
| **is_pay_at_destination** | **Boolean** | Whether the shipping method is pay at destination | [optional] |

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

