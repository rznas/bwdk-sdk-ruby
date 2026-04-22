# OpenapiClient::OrderItemCreate

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | نام کامل محصول شامل تمام مشخصات |  |
| **primary_amount** | **Integer** | قیمت اولیه برای هر واحد بدون تخفیف (به تومان) | [optional] |
| **amount** | **Integer** | قیمت نهایی برای تمام واحدها بعد از تخفیف (به تومان) | [optional] |
| **count** | **Integer** | تعداد واحدهای این کالا در سفارش |  |
| **discount_amount** | **Integer** | مبلغ کل تخفیف برای این کالا (به تومان) | [optional] |
| **tax_amount** | **Integer** | مبلغ کل مالیات برای این کالا (به تومان) | [optional] |
| **image_link** | **String** | آدرس تصویر محصول | [optional] |
| **options** | [**Array&lt;Option&gt;**](Option.md) |  |  |
| **preparation_time** | **Integer** | زمان آمادهسازی کالا (به روز) | [optional][default to 2] |
| **weight** | **Float** | وزن کالا (بر حسب گرم) | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::OrderItemCreate.new(
  name: null,
  primary_amount: null,
  amount: null,
  count: null,
  discount_amount: null,
  tax_amount: null,
  image_link: null,
  options: null,
  preparation_time: null,
  weight: null
)
```

