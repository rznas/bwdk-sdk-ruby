# OpenapiClient::OrderDetail

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** |  | [readonly] |
| **created_at** | **Time** |  | [readonly] |
| **order_uuid** | **String** |  | [readonly] |
| **reservation_expired_at** | **Integer** | Unix timestamp تا زمانی که سفارش برای پرداخت رزرو شده است | [readonly] |
| **merchant_order_id** | **String** | شناسه منحصر به فرد سفارش در سیستم فروشنده | [readonly] |
| **status** | [**OrderStatusEnum**](OrderStatusEnum.md) |  | [readonly] |
| **status_display** | **String** |  | [readonly] |
| **main_amount** | **Integer** | مجموع قیمت اولیه تمام کالاهای سفارش بدون تخفیف (به تومان) | [readonly] |
| **final_amount** | **Integer** | قیمت نهایی قابل پرداخت توسط مشتری: مبلغ_اصلی - مبلغ_تخفیف + مبلغ_مالیات (به تومان) | [readonly] |
| **total_paid_amount** | **Integer** | مبلغ کل پرداخت شده توسط کاربر: مبلغ_نهایی + هزینه_ارسال (به تومان) | [readonly] |
| **discount_amount** | **Integer** | مبلغ کل تخفیف اعمال شده بر سفارش (به تومان) | [readonly] |
| **tax_amount** | **Integer** | مبلغ کل مالیات برای سفارش (به تومان) | [readonly] |
| **shipping_amount** | **Integer** | هزینه ارسال برای سفارش (به تومان) | [readonly] |
| **loyalty_amount** | **Integer** | مقدار تخفیف از برنامه باشگاه مشتریان/پاداش (به تومان) | [readonly] |
| **callback_url** | **String** | آدرسی برای دریافت اطلاع رسانی وضعیت پرداخت پس از تکمیل سفارش | [readonly] |
| **merchant** | [**Merchant**](Merchant.md) |  |  |
| **items** | [**Array&lt;OrderItemCreate&gt;**](OrderItemCreate.md) |  |  |
| **source_address** | **Object** |  | [readonly] |
| **destination_address** | **Object** |  | [readonly] |
| **selected_shipping_method** | [**ShippingMethod**](ShippingMethod.md) |  | [readonly] |
| **shipping_selected_at** | **Time** |  | [readonly] |
| **address_selected_at** | **Time** |  | [readonly] |
| **packing_amount** | **Integer** | هزینه روش بسته‌بندی انتخاب‌شده (به تومان) | [readonly] |
| **packing_selected_at** | **Time** |  | [readonly] |
| **selected_packing** | [**Packing**](Packing.md) |  | [readonly] |
| **can_select_packing** | **Boolean** |  | [readonly] |
| **can_select_shipping** | **Boolean** |  | [readonly] |
| **can_select_address** | **Boolean** |  | [readonly] |
| **can_proceed_to_payment** | **Boolean** |  | [readonly] |
| **is_paid** | **Boolean** |  | [readonly] |
| **user** | [**OrderUser**](OrderUser.md) |  | [readonly] |
| **payment** | [**PaymentOrder**](PaymentOrder.md) |  | [readonly] |
| **preparation_time** | **Integer** | Preparation time for the order (in days) | [readonly] |
| **weight** | **Float** | Total weight of the order (in grams) | [readonly] |
| **selected_shipping_data** | **Hash&lt;String, Object&gt;** |  | [readonly] |
| **reference_code** | **String** | کد مرجع یکتا برای پیگیری سفارش مشتری (قالب: BD-XXXXXXXX) | [readonly] |
| **promotion_discount_amount** | **Float** |  | [readonly] |
| **promotion_data** | **Hash&lt;String, Object&gt;** |  | [readonly] |
| **digipay_markup_amount** | **Integer** | Markup amount for the order (in Tomans) | [readonly] |
| **markup_commission_percentage** | **Integer** | Markup commission percentage for the order (in percent) | [readonly] |
| **previous_status** | [**OrderStatusEnum**](OrderStatusEnum.md) |  | [readonly] |
| **previous_status_display** | **String** |  | [readonly] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::OrderDetail.new(
  id: null,
  created_at: null,
  order_uuid: null,
  reservation_expired_at: null,
  merchant_order_id: null,
  status: null,
  status_display: null,
  main_amount: null,
  final_amount: null,
  total_paid_amount: null,
  discount_amount: null,
  tax_amount: null,
  shipping_amount: null,
  loyalty_amount: null,
  callback_url: null,
  merchant: null,
  items: null,
  source_address: null,
  destination_address: null,
  selected_shipping_method: null,
  shipping_selected_at: null,
  address_selected_at: null,
  packing_amount: null,
  packing_selected_at: null,
  selected_packing: null,
  can_select_packing: null,
  can_select_shipping: null,
  can_select_address: null,
  can_proceed_to_payment: null,
  is_paid: null,
  user: null,
  payment: null,
  preparation_time: null,
  weight: null,
  selected_shipping_data: null,
  reference_code: null,
  promotion_discount_amount: null,
  promotion_data: null,
  digipay_markup_amount: null,
  markup_commission_percentage: null,
  previous_status: null,
  previous_status_display: null
)
```

