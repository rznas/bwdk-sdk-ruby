# OpenapiClient::OrderCreate

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **merchant_order_id** | **String** | شناسه منحصر به فرد این سفارش در سیستم فروشنده |  |
| **merchant_unique_id** | **String** | شناسه منحصر به فرد برای تأیید اصالت سفارش |  |
| **main_amount** | **Integer** | مجموع قیمت‌های اولیه تمام کالاها بدون تخفیف (به تومان) | [optional] |
| **final_amount** | **Integer** | مبلغ نهایی: مبلغ_اصلی - مبلغ_تخفیف + مبلغ_مالیات (به تومان) | [optional] |
| **total_paid_amount** | **Integer** | مبلغ کل پرداخت شده توسط کاربر: مبلغ_نهایی + هزینه_ارسال (به تومان) | [optional] |
| **discount_amount** | **Integer** | مبلغ کل تخفیف برای تمام سفارش (به تومان) | [optional] |
| **tax_amount** | **Integer** | مبلغ کل مالیات برای تمام سفارش (به تومان) | [optional] |
| **shipping_amount** | **Integer** | هزینه ارسال برای سفارش (به تومان) | [optional] |
| **loyalty_amount** | **Integer** | مبلغ تخفیف باشگاه مشتریان/پاداش (به تومان) | [optional] |
| **callback_url** | **String** | آدرس وب‌هوک برای دریافت اطلاع رسانی وضعیت پرداخت |  |
| **destination_address** | **Object** |  | [readonly] |
| **items** | [**Array&lt;OrderItemCreate&gt;**](OrderItemCreate.md) |  |  |
| **merchant** | **Integer** | مقدار توسط سیستم جایگذاری می شود | [optional] |
| **source_address** | **Object** | مقدار توسط سیستم جایگذاری می شود | [optional] |
| **user** | **Integer** |  | [readonly] |
| **reservation_expired_at** | **Integer** | مهلت پرداخت (به عنوان Unix timestamp) قبل از اتمام سفارش | [optional] |
| **reference_code** | **String** | کد مرجع یکتا برای پیگیری سفارش مشتری (قالب: BD-XXXXXXXX) | [readonly] |
| **preparation_time** | **Integer** | Preparation time for the order (in days) | [optional][default to 2] |
| **weight** | **Float** | Total Weight of the order (in grams) | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::OrderCreate.new(
  merchant_order_id: null,
  merchant_unique_id: null,
  main_amount: null,
  final_amount: null,
  total_paid_amount: null,
  discount_amount: null,
  tax_amount: null,
  shipping_amount: null,
  loyalty_amount: null,
  callback_url: null,
  destination_address: null,
  items: null,
  merchant: null,
  source_address: null,
  user: null,
  reservation_expired_at: null,
  reference_code: null,
  preparation_time: null,
  weight: null
)
```

