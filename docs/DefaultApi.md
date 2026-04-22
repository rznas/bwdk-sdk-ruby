# OpenapiClient::DefaultApi

All URIs are relative to *https://bwdk-backend.digify.shop*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**merchant_api_v1_auth_status_retrieve**](DefaultApi.md#merchant_api_v1_auth_status_retrieve) | **GET** /merchant/api/v1/auth/status/ | وضعیت لاگین بودن |
| [**order_api_v1_create_order_create**](DefaultApi.md#order_api_v1_create_order_create) | **POST** /order/api/v1/create-order/ | ساخت سفارش |
| [**order_api_v1_manager_cancel_shipment_create**](DefaultApi.md#order_api_v1_manager_cancel_shipment_create) | **POST** /order/api/v1/manager/{order_uuid}/cancel-shipment/ | لغو ارسال سفارش |
| [**order_api_v1_manager_change_shipping_method_update**](DefaultApi.md#order_api_v1_manager_change_shipping_method_update) | **PUT** /order/api/v1/manager/{order_uuid}/change-shipping-method/ | تغییر روش ارسال |
| [**order_api_v1_manager_list**](DefaultApi.md#order_api_v1_manager_list) | **GET** /order/api/v1/manager/ | لیست سفارشات |
| [**order_api_v1_manager_paid_list**](DefaultApi.md#order_api_v1_manager_paid_list) | **GET** /order/api/v1/manager/paid/ | سفارش پرداخت‌شده و تایید‌نشده |
| [**order_api_v1_manager_refund_create**](DefaultApi.md#order_api_v1_manager_refund_create) | **POST** /order/api/v1/manager/{order_uuid}/refund/ | بازگشت سفارش |
| [**order_api_v1_manager_retrieve**](DefaultApi.md#order_api_v1_manager_retrieve) | **GET** /order/api/v1/manager/{order_uuid}/ | دریافت سفارش |
| [**order_api_v1_manager_revive_shipment_create**](DefaultApi.md#order_api_v1_manager_revive_shipment_create) | **POST** /order/api/v1/manager/{order_uuid}/revive-shipment/ | احیای ارسال سفارش |
| [**order_api_v1_manager_update_status_update**](DefaultApi.md#order_api_v1_manager_update_status_update) | **PUT** /order/api/v1/manager/{order_uuid}/update-status/ | به‌روزرسانی وضعیت سفارش |
| [**order_api_v1_manager_verify_create**](DefaultApi.md#order_api_v1_manager_verify_create) | **POST** /order/api/v1/manager/{order_uuid}/verify/ | تایید سفارش |
| [**wallets_api_v1_wallet_balance_retrieve**](DefaultApi.md#wallets_api_v1_wallet_balance_retrieve) | **GET** /wallets/api/v1/wallet-balance/ | دریافت موجودی کیف پول |


## merchant_api_v1_auth_status_retrieve

> <AuthStatusResponse> merchant_api_v1_auth_status_retrieve

وضعیت لاگین بودن

<div dir=\"rtl\" style=\"text-align: right;\">  بررسی وضعیت احراز هویت فروشنده  ## توضیحات  این endpoint برای بررسی اعتبار **API_KEY** فروشنده استفاده می‌شود. اگر کلید معتبر باشد، پاسخ `is_authenticated: true` برمی‌گردد. از این endpoint برای تأیید صحت کلید API قبل از شروع عملیات استفاده کنید.  نیاز به **API_KEY** فروشنده دارد (فقط Header لازم است، بدنه درخواست ندارد).  </div> 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new

begin
  # وضعیت لاگین بودن
  result = api_instance.merchant_api_v1_auth_status_retrieve
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->merchant_api_v1_auth_status_retrieve: #{e}"
end
```

#### Using the merchant_api_v1_auth_status_retrieve_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AuthStatusResponse>, Integer, Hash)> merchant_api_v1_auth_status_retrieve_with_http_info

```ruby
begin
  # وضعیت لاگین بودن
  data, status_code, headers = api_instance.merchant_api_v1_auth_status_retrieve_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AuthStatusResponse>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->merchant_api_v1_auth_status_retrieve_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**AuthStatusResponse**](AuthStatusResponse.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## order_api_v1_create_order_create

> <OrderCreateResponse> order_api_v1_create_order_create(order_create)

ساخت سفارش

<div dir=\"rtl\" style=\"text-align: right;\">  ساخت سفارش جدید در سیستم BWDK  ## توضیحات  این endpoint برای ایجاد یک سفارش جدید در سیستم خرید با دیجی‌کالا استفاده می‌شود. در این درخواست باید اطلاعات سفارش، اقلام سبد خرید، و آدرس callback شامل شود.  برای شروع ارتباط با سرویس‌های **خرید با دیجی‌کالا** شما باید دارای **API_KEY** باشید که این مورد از سمت تیم دیجی‌فای در اختیار شما قرار خواهد گرفت.  ### روند کاری  **مرحله ۱: درخواست ساخت سفارش**  کاربر پس از انتخاب کالاهای خود در سبد خرید، بر روی دکمه **خرید با دیجی‌کالا** کلیک می‌کند و بک‌اند مرچنت درخواستی برای ساخت سفارش BWDK دریافت می‌کند. در این مرحله اولین درخواست خود را به بک‌اند BWDK ارسال می‌نمایید:  BWDK یک سفارش جدید برای مرچنت با وضعیت **INITIAL** ایجاد می‌کند و **order_uuid** را جنریت می‌کند. آدرس **order_start_url** نقطه شروع مسیر تکمیل سفارش است (انتخاب آدرس، شیپینگ، پکینگ، پرداخت و غیره). <br> </div>  ```mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API     participant C as مشتری     participant PG as درگاه پرداخت      M->>API: POST /api/v1/orders/create     Note over M,API: شناسه سفارش, کالاها, مبلغ, callback_url     API-->>M: {لینک شروع سفارش, شناسه سفارش}      M->>C: تغییر مسیر به لینک شروع      C->>API: تکمیل درخواست خرید توسط مشتری     API->>PG: شروع فرآیند پرداخت     PG-->>C: نتیجه پرداخت     PG->>API: تأیید پرداخت     API-->>C: تغییر مسیر به callback_url      M->>API: POST /api/v1/orders/manager/{uuid}/verify     Note over M,API: {شناسه منحصربفرد فروشنده}     API-->>M: سفارش تأیید شد و آماده ارسال است ```  </div> 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
order_create = OpenapiClient::OrderCreate.new({merchant_order_id: 'merchant_order_id_example', merchant_unique_id: 'merchant_unique_id_example', callback_url: 'callback_url_example', destination_address: 3.56, items: [OpenapiClient::OrderItemCreate.new({name: 'name_example', count: 37, options: [OpenapiClient::Option.new({type_name: OpenapiClient::TypeNameEnum::COLOR, name: 'name_example', value: 'value_example'})]})], user: 37, reference_code: 'reference_code_example'}) # OrderCreate | 

begin
  # ساخت سفارش
  result = api_instance.order_api_v1_create_order_create(order_create)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_create_order_create: #{e}"
end
```

#### Using the order_api_v1_create_order_create_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<OrderCreateResponse>, Integer, Hash)> order_api_v1_create_order_create_with_http_info(order_create)

```ruby
begin
  # ساخت سفارش
  data, status_code, headers = api_instance.order_api_v1_create_order_create_with_http_info(order_create)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <OrderCreateResponse>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_create_order_create_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_create** | [**OrderCreate**](OrderCreate.md) |  |  |

### Return type

[**OrderCreateResponse**](OrderCreateResponse.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
- **Accept**: application/json


## order_api_v1_manager_cancel_shipment_create

> <MerchantOrderCancelShipmentResponse> order_api_v1_manager_cancel_shipment_create(order_uuid)

لغو ارسال سفارش

<div dir=\"rtl\" style=\"text-align: right;\">  لغو مرسوله دیجی‌اکسپرس  ## توضیحات  این endpoint برای لغو یک مرسوله ثبت‌شده در سرویس دیجی‌اکسپرس استفاده می‌شود. پس از لغو موفق، مرسوله از صف ارسال خارج می‌شود.  نیاز به **API_KEY** فروشنده دارد.  ## شرایط لغو  * سفارش باید دارای روش ارسال **DigiExpress** باشد * مرسوله باید در وضعیت **در انتظار تحویل به پیک** (Request for Pickup) باشد  </div>  ```mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API     participant DX as دیجی‌اکسپرس      M->>API: POST /order/api/v1/manager/{order_uuid}/cancel-shipment/     Note over M,API: Header: X-API-KEY (بدون بدنه)      alt روش ارسال DigiExpress نیست         API-->>M: 400 خطا         Note over API,M: {error: \"Selected shipping method is not DigiExpress\"}     else مرسوله قابل لغو نیست         API-->>M: 400 خطا         Note over API,M: {error: \"...\"}     else لغو موفق         API->>DX: لغو مرسوله         DX-->>API: تأیید لغو         API-->>M: 200 موفق         Note over API,M: {message, order_uuid, status, status_display}     end ``` 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 

begin
  # لغو ارسال سفارش
  result = api_instance.order_api_v1_manager_cancel_shipment_create(order_uuid)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_cancel_shipment_create: #{e}"
end
```

#### Using the order_api_v1_manager_cancel_shipment_create_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<MerchantOrderCancelShipmentResponse>, Integer, Hash)> order_api_v1_manager_cancel_shipment_create_with_http_info(order_uuid)

```ruby
begin
  # لغو ارسال سفارش
  data, status_code, headers = api_instance.order_api_v1_manager_cancel_shipment_create_with_http_info(order_uuid)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <MerchantOrderCancelShipmentResponse>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_cancel_shipment_create_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_uuid** | **String** |  |  |

### Return type

[**MerchantOrderCancelShipmentResponse**](MerchantOrderCancelShipmentResponse.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## order_api_v1_manager_change_shipping_method_update

> <OrderDetail> order_api_v1_manager_change_shipping_method_update(order_uuid, order_detail)

تغییر روش ارسال

<div dir=\"rtl\" style=\"text-align: right;\">  تغییر روش ارسال سفارش  ## توضیحات  این endpoint به فروشنده اجازه می‌دهد روش ارسال یک سفارش را تغییر دهد. این عملیات معمولاً زمانی استفاده می‌شود که فروشنده بخواهد از DigiExpress به روش ارسال پیش‌فرض (یا بالعکس) تغییر دهد.  نیاز به **API_KEY** فروشنده دارد.  ## پارامترهای ورودی  * **updated_shipping**: شناسه روش ارسال جدید * **preparation_time** (اختیاری): زمان آماده‌سازی (روز) برای DigiExpress  </div> 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
order_detail = OpenapiClient::OrderDetail.new({id: 37, created_at: Time.now, order_uuid: 'order_uuid_example', reservation_expired_at: 37, merchant_order_id: 'merchant_order_id_example', status: OpenapiClient::OrderStatusEnum::N1, status_display: 'status_display_example', main_amount: 37, final_amount: 37, total_paid_amount: 37, discount_amount: 37, tax_amount: 37, shipping_amount: 37, loyalty_amount: 37, callback_url: 'callback_url_example', merchant: OpenapiClient::Merchant.new({domain: 'domain_example', logo: 'logo_example'}), items: [OpenapiClient::OrderItemCreate.new({name: 'name_example', count: 37, options: [OpenapiClient::Option.new({type_name: OpenapiClient::TypeNameEnum::COLOR, name: 'name_example', value: 'value_example'})]})], source_address: 3.56, destination_address: 3.56, selected_shipping_method: OpenapiClient::ShippingMethod.new({id: 37, name: 'name_example', get_shipping_type_display: 'get_shipping_type_display_example', shipping_type_display: 'shipping_type_display_example', delivery_time_display: 'delivery_time_display_example', delivery_time_range_display: OpenapiClient::DeliveryTimeRangeDisplay.new({min_date: 'min_date_example', max_date: 'max_date_example'}), inventory_address: OpenapiClient::BusinessAddress.new({id: 37, address: 'address_example', city_name: 'city_name_example', state_name: 'state_name_example', created_at: Time.now, modified_at: Time.now})}), shipping_selected_at: Time.now, address_selected_at: Time.now, packing_amount: 37, packing_selected_at: Time.now, selected_packing: OpenapiClient::Packing.new({id: 37, name: 'name_example'}), can_select_packing: false, can_select_shipping: false, can_select_address: false, can_proceed_to_payment: false, is_paid: false, user: OpenapiClient::OrderUser.new, payment: OpenapiClient::PaymentOrder.new({final_amount: 37, gateway_type: OpenapiClient::GatewayTypeEnum::N1, gateway_type_display: 'gateway_type_display_example', paid_at: 'paid_at_example', gateway_name: 'gateway_name_example', invoice_id: 'invoice_id_example', settlement_date: 'settlement_date_example', settlement_status: 37, settlement_status_display: 'settlement_status_display_example'}), preparation_time: 37, weight: 3.56, selected_shipping_data: { key: 3.56}, reference_code: 'reference_code_example', promotion_discount_amount: 3.56, promotion_data: { key: 3.56}, digipay_markup_amount: 37, markup_commission_percentage: 37, previous_status: OpenapiClient::OrderStatusEnum::N1, previous_status_display: 'previous_status_display_example'}) # OrderDetail | 

begin
  # تغییر روش ارسال
  result = api_instance.order_api_v1_manager_change_shipping_method_update(order_uuid, order_detail)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_change_shipping_method_update: #{e}"
end
```

#### Using the order_api_v1_manager_change_shipping_method_update_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<OrderDetail>, Integer, Hash)> order_api_v1_manager_change_shipping_method_update_with_http_info(order_uuid, order_detail)

```ruby
begin
  # تغییر روش ارسال
  data, status_code, headers = api_instance.order_api_v1_manager_change_shipping_method_update_with_http_info(order_uuid, order_detail)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <OrderDetail>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_change_shipping_method_update_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_uuid** | **String** |  |  |
| **order_detail** | [**OrderDetail**](OrderDetail.md) |  |  |

### Return type

[**OrderDetail**](OrderDetail.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
- **Accept**: application/json


## order_api_v1_manager_list

> <PaginatedOrderDetailList> order_api_v1_manager_list(opts)

لیست سفارشات

<div dir=\"rtl\" style=\"text-align: right;\">  لیست سفارشات فروشنده  ## توضیحات  این endpoint لیست تمام سفارشات مرتبط با فروشنده را با امکان فیلتر، جستجو و مرتب‌سازی برمی‌گرداند. نتایج به صورت صفحه‌بندی‌شده (Cursor Pagination) ارسال می‌شوند و به ترتیب جدیدترین سفارش اول مرتب می‌شوند.  نیاز به **API_KEY** فروشنده دارد.  ## پارامترهای فیلتر  * **status**: وضعیت سفارش (INITIAL, PENDING, PAID_BY_USER, VERIFIED_BY_MERCHANT, ...) * **created_at__gte / created_at__lte**: فیلتر بر اساس تاریخ ایجاد * **search**: جستجو در شماره تلفن مشتری، نام، کد مرجع، شناسه سفارش مرچنت * **ordering**: مرتب‌سازی بر اساس created_at, final_amount, status, merchant_order_id  </div> 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
opts = {
  cities: 'cities_example', # String | 
  created_at: Date.parse('2013-10-20'), # Date | 
  cursor: 'cursor_example', # String | مقدار نشانگر صفحه‌بندی.
  order_ids: 'order_ids_example', # String | 
  ordering: 'ordering_example', # String | کدام فیلد باید هنگام مرتب‌سازی نتایج استفاده شود.
  payment_types: 'payment_types_example', # String | 
  provinces: 'provinces_example', # String | 
  reference_code: 'reference_code_example', # String | 
  search: 'search_example', # String | یک عبارت جستجو.
  shipping_types: 'shipping_types_example', # String | 
  status: 1, # Integer | * `1` - اولیه * `2` - شروع در * `3` - در انتظار * `4` - در انتظار درگاه * `5` - منقضی شده * `6` - لغو شده * `7` - ممنوع شده توسط ما * `8` - ناموفق در پرداخت * `9` - تأیید شده توسط فروشنده * `10` - ناموفق در تأیید توسط فروشنده * `11` - فروشگاه * `12` - لغو شده توسط فروشنده * `13` - درخواست بازگرداندن وجه به مشتری به دلیل درخواست مشتری * `14` - درخواست بازگرداندن وجه به فروشنده پس از ناموفقی در تأیید توسط فروشنده * `15` - درخواست بازگرداندن وجه به مشتری پس از ناموفقی توسط فروشنده * `16` - بازگردانده شده به فروشنده پس از لغو توسط فروشنده * `17` - بازگرداندن وجه تکمیل شد * `18` - زمان مجاز برای منقضی کردن گذشته است * `19` - تحویل نشده * `20` - مرسوله
  statuses: 'statuses_example', # String | 
  today_pickup: true # Boolean | 
}

begin
  # لیست سفارشات
  result = api_instance.order_api_v1_manager_list(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_list: #{e}"
end
```

#### Using the order_api_v1_manager_list_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PaginatedOrderDetailList>, Integer, Hash)> order_api_v1_manager_list_with_http_info(opts)

```ruby
begin
  # لیست سفارشات
  data, status_code, headers = api_instance.order_api_v1_manager_list_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PaginatedOrderDetailList>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_list_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **cities** | **String** |  | [optional] |
| **created_at** | **Date** |  | [optional] |
| **cursor** | **String** | مقدار نشانگر صفحه‌بندی. | [optional] |
| **order_ids** | **String** |  | [optional] |
| **ordering** | **String** | کدام فیلد باید هنگام مرتب‌سازی نتایج استفاده شود. | [optional] |
| **payment_types** | **String** |  | [optional] |
| **provinces** | **String** |  | [optional] |
| **reference_code** | **String** |  | [optional] |
| **search** | **String** | یک عبارت جستجو. | [optional] |
| **shipping_types** | **String** |  | [optional] |
| **status** | **Integer** | * &#x60;1&#x60; - اولیه * &#x60;2&#x60; - شروع در * &#x60;3&#x60; - در انتظار * &#x60;4&#x60; - در انتظار درگاه * &#x60;5&#x60; - منقضی شده * &#x60;6&#x60; - لغو شده * &#x60;7&#x60; - ممنوع شده توسط ما * &#x60;8&#x60; - ناموفق در پرداخت * &#x60;9&#x60; - تأیید شده توسط فروشنده * &#x60;10&#x60; - ناموفق در تأیید توسط فروشنده * &#x60;11&#x60; - فروشگاه * &#x60;12&#x60; - لغو شده توسط فروشنده * &#x60;13&#x60; - درخواست بازگرداندن وجه به مشتری به دلیل درخواست مشتری * &#x60;14&#x60; - درخواست بازگرداندن وجه به فروشنده پس از ناموفقی در تأیید توسط فروشنده * &#x60;15&#x60; - درخواست بازگرداندن وجه به مشتری پس از ناموفقی توسط فروشنده * &#x60;16&#x60; - بازگردانده شده به فروشنده پس از لغو توسط فروشنده * &#x60;17&#x60; - بازگرداندن وجه تکمیل شد * &#x60;18&#x60; - زمان مجاز برای منقضی کردن گذشته است * &#x60;19&#x60; - تحویل نشده * &#x60;20&#x60; - مرسوله | [optional] |
| **statuses** | **String** |  | [optional] |
| **today_pickup** | **Boolean** |  | [optional] |

### Return type

[**PaginatedOrderDetailList**](PaginatedOrderDetailList.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## order_api_v1_manager_paid_list

> <PaginatedMerchantPaidOrderListList> order_api_v1_manager_paid_list(opts)

سفارش پرداخت‌شده و تایید‌نشده

لیست تمامی سفارشاتی که توسط کاربر پرداخت شده اند ولی توسط فروشنده تایید نشده اند. 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
opts = {
  cities: 'cities_example', # String | 
  created_at: Date.parse('2013-10-20'), # Date | 
  cursor: 'cursor_example', # String | مقدار نشانگر صفحه‌بندی.
  order_ids: 'order_ids_example', # String | 
  ordering: 'ordering_example', # String | کدام فیلد باید هنگام مرتب‌سازی نتایج استفاده شود.
  payment_types: 'payment_types_example', # String | 
  provinces: 'provinces_example', # String | 
  reference_code: 'reference_code_example', # String | 
  search: 'search_example', # String | یک عبارت جستجو.
  shipping_types: 'shipping_types_example', # String | 
  status: 1, # Integer | * `1` - اولیه * `2` - شروع در * `3` - در انتظار * `4` - در انتظار درگاه * `5` - منقضی شده * `6` - لغو شده * `7` - ممنوع شده توسط ما * `8` - ناموفق در پرداخت * `9` - تأیید شده توسط فروشنده * `10` - ناموفق در تأیید توسط فروشنده * `11` - فروشگاه * `12` - لغو شده توسط فروشنده * `13` - درخواست بازگرداندن وجه به مشتری به دلیل درخواست مشتری * `14` - درخواست بازگرداندن وجه به فروشنده پس از ناموفقی در تأیید توسط فروشنده * `15` - درخواست بازگرداندن وجه به مشتری پس از ناموفقی توسط فروشنده * `16` - بازگردانده شده به فروشنده پس از لغو توسط فروشنده * `17` - بازگرداندن وجه تکمیل شد * `18` - زمان مجاز برای منقضی کردن گذشته است * `19` - تحویل نشده * `20` - مرسوله
  statuses: 'statuses_example', # String | 
  today_pickup: true # Boolean | 
}

begin
  # سفارش پرداخت‌شده و تایید‌نشده
  result = api_instance.order_api_v1_manager_paid_list(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_paid_list: #{e}"
end
```

#### Using the order_api_v1_manager_paid_list_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PaginatedMerchantPaidOrderListList>, Integer, Hash)> order_api_v1_manager_paid_list_with_http_info(opts)

```ruby
begin
  # سفارش پرداخت‌شده و تایید‌نشده
  data, status_code, headers = api_instance.order_api_v1_manager_paid_list_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PaginatedMerchantPaidOrderListList>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_paid_list_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **cities** | **String** |  | [optional] |
| **created_at** | **Date** |  | [optional] |
| **cursor** | **String** | مقدار نشانگر صفحه‌بندی. | [optional] |
| **order_ids** | **String** |  | [optional] |
| **ordering** | **String** | کدام فیلد باید هنگام مرتب‌سازی نتایج استفاده شود. | [optional] |
| **payment_types** | **String** |  | [optional] |
| **provinces** | **String** |  | [optional] |
| **reference_code** | **String** |  | [optional] |
| **search** | **String** | یک عبارت جستجو. | [optional] |
| **shipping_types** | **String** |  | [optional] |
| **status** | **Integer** | * &#x60;1&#x60; - اولیه * &#x60;2&#x60; - شروع در * &#x60;3&#x60; - در انتظار * &#x60;4&#x60; - در انتظار درگاه * &#x60;5&#x60; - منقضی شده * &#x60;6&#x60; - لغو شده * &#x60;7&#x60; - ممنوع شده توسط ما * &#x60;8&#x60; - ناموفق در پرداخت * &#x60;9&#x60; - تأیید شده توسط فروشنده * &#x60;10&#x60; - ناموفق در تأیید توسط فروشنده * &#x60;11&#x60; - فروشگاه * &#x60;12&#x60; - لغو شده توسط فروشنده * &#x60;13&#x60; - درخواست بازگرداندن وجه به مشتری به دلیل درخواست مشتری * &#x60;14&#x60; - درخواست بازگرداندن وجه به فروشنده پس از ناموفقی در تأیید توسط فروشنده * &#x60;15&#x60; - درخواست بازگرداندن وجه به مشتری پس از ناموفقی توسط فروشنده * &#x60;16&#x60; - بازگردانده شده به فروشنده پس از لغو توسط فروشنده * &#x60;17&#x60; - بازگرداندن وجه تکمیل شد * &#x60;18&#x60; - زمان مجاز برای منقضی کردن گذشته است * &#x60;19&#x60; - تحویل نشده * &#x60;20&#x60; - مرسوله | [optional] |
| **statuses** | **String** |  | [optional] |
| **today_pickup** | **Boolean** |  | [optional] |

### Return type

[**PaginatedMerchantPaidOrderListList**](PaginatedMerchantPaidOrderListList.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## order_api_v1_manager_refund_create

> <MerchantOrderRefundResponse> order_api_v1_manager_refund_create(order_uuid, opts)

بازگشت سفارش

<div dir=\"rtl\" style=\"text-align: right;\"> بازگشت و لغو سفارش  ## توضیحات  این endpoint برای بازگشت یا لغو سفارشی استفاده می‌شود که قبلاً پرداخت شده یا تایید شده است. در این مرحله مبلغ سفارش به کاربر بازگشت داده می‌شود و وضعیت سفارش به **REFUNDED** تغییر می‌یابد.   ## شرایط بازگشت  سفارش باید در یکی از وضعیت‌های زیر باشد تا بازگشت امکان‌پذیر باشد: * **PAID_BY_USER**: سفارش پرداخت شده است اما هنوز تایید نشده * **VERIFIED_BY_MERCHANT**: سفارش تایید شده است  سفارش نباید قبلاً بازگشت داده شده باشد.  **پاسخ خطا** - اگر سفارش در وضعیت مناسب نباشد یا قبلاً بازگشت داده شده باشد </div>  ```mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API      M->>API: POST /api/v1/orders/manager/{uuid}/refund     Note over M,API: {reason: \"درخواست مشتری\"}      alt سفارش قابل بازگشت نیست         API-->>M: 500 خطا         Note over API,M: {error: \"شروع بازگشت ناموفق بود.<br/>لطفاً دوباره تلاش کنید.\"}     else سفارش معتبر است         API-->>M: 200 موفق         Note over API,M: {message: \"درخواست بازگشت با<br/>موفقیت شروع شد\",<br/>order_uuid, status: 13,<br/>status_display,<br/>refund_reason}          M->>API: GET /api/v1/orders/manager/{uuid}         Note over M,API: بررسی وضعیت سفارش<br/>(endpoint جداگانه /refund/status وجود ندارد)          alt status: 17 (بازگشت تکمیل شد)             API-->>M: 200 موفق             Note over API,M: {order_uuid, status: 17,<br/>status_display: \"بازگشت تکمیل شد\",<br/>metadata.refund_tracking_code,<br/>metadata.refund_completed_at}          else status: 13 (در حال پردازش)             API-->>M: 200 موفق             Note over API,M: {order_uuid, status: 13,<br/>status_display: \"درخواست بازگشت به مشتری<br/>به دلیل درخواست<br/>مشتری\",<br/>metadata.refund_reason}          else status: قبلی (بازگشت ناموفق)             API-->>M: 200 موفق             Note over API,M: {order_uuid, status: (قبلی),<br/>metadata.refund_error,<br/>metadata.refund_failed_at}         end     end ``` 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
opts = {
  refund_order: OpenapiClient::RefundOrder.new # RefundOrder | 
}

begin
  # بازگشت سفارش
  result = api_instance.order_api_v1_manager_refund_create(order_uuid, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_refund_create: #{e}"
end
```

#### Using the order_api_v1_manager_refund_create_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<MerchantOrderRefundResponse>, Integer, Hash)> order_api_v1_manager_refund_create_with_http_info(order_uuid, opts)

```ruby
begin
  # بازگشت سفارش
  data, status_code, headers = api_instance.order_api_v1_manager_refund_create_with_http_info(order_uuid, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <MerchantOrderRefundResponse>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_refund_create_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_uuid** | **String** |  |  |
| **refund_order** | [**RefundOrder**](RefundOrder.md) |  | [optional] |

### Return type

[**MerchantOrderRefundResponse**](MerchantOrderRefundResponse.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
- **Accept**: application/json


## order_api_v1_manager_retrieve

> <OrderDetail> order_api_v1_manager_retrieve(order_uuid)

دریافت سفارش

<div dir=\"rtl\" style=\"text-align: right;\">  # مدیریت سفارشات  ## توضیحات  این endpoint برای مدیریت و مشاهده سفارشات فروشنده استفاده می‌شود.  </div> 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 

begin
  # دریافت سفارش
  result = api_instance.order_api_v1_manager_retrieve(order_uuid)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_retrieve: #{e}"
end
```

#### Using the order_api_v1_manager_retrieve_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<OrderDetail>, Integer, Hash)> order_api_v1_manager_retrieve_with_http_info(order_uuid)

```ruby
begin
  # دریافت سفارش
  data, status_code, headers = api_instance.order_api_v1_manager_retrieve_with_http_info(order_uuid)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <OrderDetail>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_retrieve_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_uuid** | **String** |  |  |

### Return type

[**OrderDetail**](OrderDetail.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## order_api_v1_manager_revive_shipment_create

> <MerchantOrderReviveShipmentResponse> order_api_v1_manager_revive_shipment_create(order_uuid, opts)

احیای ارسال سفارش

<div dir=\"rtl\" style=\"text-align: right;\">  احیای مرسوله دیجی‌اکسپرس  ## توضیحات  این endpoint برای احیای (reactivate) یک مرسوله دیجی‌اکسپرس که قبلاً لغو شده یا در وضعیت غیرفعال است استفاده می‌شود. با ارسال `preparation_time` (زمان آماده‌سازی بر حسب روز)، زمان جدید آماده بودن بار تنظیم می‌شود.  نیاز به **API_KEY** فروشنده دارد.  ## پارامترهای ورودی  * **preparation_time** (اختیاری، پیش‌فرض: ۲): تعداد روز تا آماده‌شدن بار برای تحویل به پیک  ## شرایط  * سفارش باید دارای روش ارسال **DigiExpress** باشد * مرسوله باید در وضعیت قابل احیا باشد  </div>  ```mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API     participant DX as دیجی‌اکسپرس      M->>API: POST /order/api/v1/manager/{order_uuid}/revive-shipment/     Note over M,API: Header: X-API-KEY<br/>{preparation_time: 2}      alt روش ارسال DigiExpress نیست         API-->>M: 400 خطا         Note over API,M: {error: \"Selected shipping method is not DigiExpress\"}     else احیا موفق         API->>DX: احیای مرسوله با زمان جدید         DX-->>API: تأیید احیا         API-->>M: 200 موفق         Note over API,M: {message, order_uuid, status, status_display}     end ``` 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
opts = {
  revive_shipment: OpenapiClient::ReviveShipment.new # ReviveShipment | 
}

begin
  # احیای ارسال سفارش
  result = api_instance.order_api_v1_manager_revive_shipment_create(order_uuid, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_revive_shipment_create: #{e}"
end
```

#### Using the order_api_v1_manager_revive_shipment_create_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<MerchantOrderReviveShipmentResponse>, Integer, Hash)> order_api_v1_manager_revive_shipment_create_with_http_info(order_uuid, opts)

```ruby
begin
  # احیای ارسال سفارش
  data, status_code, headers = api_instance.order_api_v1_manager_revive_shipment_create_with_http_info(order_uuid, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <MerchantOrderReviveShipmentResponse>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_revive_shipment_create_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_uuid** | **String** |  |  |
| **revive_shipment** | [**ReviveShipment**](ReviveShipment.md) |  | [optional] |

### Return type

[**MerchantOrderReviveShipmentResponse**](MerchantOrderReviveShipmentResponse.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
- **Accept**: application/json


## order_api_v1_manager_update_status_update

> <OrderDetail> order_api_v1_manager_update_status_update(order_uuid, update_order_status)

به‌روزرسانی وضعیت سفارش

<div dir=\"rtl\" style=\"text-align: right;\">  بروزرسانی وضعیت سفارش  ## توضیحات  این endpoint به فروشنده امکان می‌دهد وضعیت یک سفارش را به‌صورت مستقیم تغییر دهد. این endpoint برای مواردی مانند علامت‌گذاری سفارش به‌عنوان «ارسال شده» یا «تحویل داده شده» توسط فروشنده استفاده می‌شود.  نیاز به **API_KEY** فروشنده دارد.  ## وضعیت‌های مجاز  * **DELIVERED**: تحویل شد * **DISPATCHED**: ارسال شد * سایر وضعیت‌های تعریف‌شده در سیستم  </div>  ```mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API      M->>API: PUT /order/api/v1/manager/{order_uuid}/update-status/     Note over M,API: Header: X-API-KEY<br/>{status: \"DELIVERED\"}      alt وضعیت معتبر است         API-->>M: 200 موفق         Note over API,M: اطلاعات کامل سفارش با وضعیت جدید     else وضعیت نامعتبر است         API-->>M: 400 خطا         Note over API,M: {error: \"invalid status\"}     end ``` 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
update_order_status = OpenapiClient::UpdateOrderStatus.new({status: OpenapiClient::OrderStatusEnum::N1}) # UpdateOrderStatus | 

begin
  # به‌روزرسانی وضعیت سفارش
  result = api_instance.order_api_v1_manager_update_status_update(order_uuid, update_order_status)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_update_status_update: #{e}"
end
```

#### Using the order_api_v1_manager_update_status_update_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<OrderDetail>, Integer, Hash)> order_api_v1_manager_update_status_update_with_http_info(order_uuid, update_order_status)

```ruby
begin
  # به‌روزرسانی وضعیت سفارش
  data, status_code, headers = api_instance.order_api_v1_manager_update_status_update_with_http_info(order_uuid, update_order_status)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <OrderDetail>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_update_status_update_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_uuid** | **String** |  |  |
| **update_order_status** | [**UpdateOrderStatus**](UpdateOrderStatus.md) |  |  |

### Return type

[**OrderDetail**](OrderDetail.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
- **Accept**: application/json


## order_api_v1_manager_verify_create

> <OrderDetail> order_api_v1_manager_verify_create(order_uuid, verify_order)

تایید سفارش

<div dir=\"rtl\" style=\"text-align: right;\">  تایید سفارش پس از پرداخت  ## توضیحات  پس از اتمام فرایند پرداخت توسط کاربر، مرچنت باید سفارش را تایید کند. این endpoint برای تایید و نهایی کردن سفارش پس از پرداخت موفق توسط مشتری استفاده می‌شود. در این مرحله مرچنت سفارش را تایید می‌کند و وضعیت سفارش به **VERIFIED_BY_MERCHANT** تغییر می‌یابد.  ## روند کاری  **مرحله ۲: بازگشت کاربر و دریافت نتیجه**  پس از تکمیل فرایند پرداخت (موفق یا ناموفق)، کاربر به آدرس callback_url که هنگام ساخت سفارش ارسال کرده بودید بازگردانده می‌شود. در این درخواست وضعیت سفارش به صورت query parameters ارسال می‌شود:   **Query Parameters:** * **success**: متغیر منطقی نشان‌دهنده موفق یا ناموفق بودن سفارش * **status**: وضعیت سفارش (PAID، FAILED، وغیره) * **phone_number**: شماره تلفن مشتری * **order_uuid**: شناسه یکتای سفارش * **merchant_order_id**: شناسه سفارش در سیستم مرچنت  **مرحله ۳: تایید سفارش در بک‌اند**  سپس شما باید این endpoint را فراخوانی کنید تا سفارش را تایید کنید و اطمینان حاصل کنید که سفارش موفقیت‌آمیز ثبت شده است: </div> 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
verify_order = OpenapiClient::VerifyOrder.new({merchant_unique_id: 'merchant_unique_id_example'}) # VerifyOrder | 

begin
  # تایید سفارش
  result = api_instance.order_api_v1_manager_verify_create(order_uuid, verify_order)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_verify_create: #{e}"
end
```

#### Using the order_api_v1_manager_verify_create_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<OrderDetail>, Integer, Hash)> order_api_v1_manager_verify_create_with_http_info(order_uuid, verify_order)

```ruby
begin
  # تایید سفارش
  data, status_code, headers = api_instance.order_api_v1_manager_verify_create_with_http_info(order_uuid, verify_order)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <OrderDetail>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->order_api_v1_manager_verify_create_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **order_uuid** | **String** |  |  |
| **verify_order** | [**VerifyOrder**](VerifyOrder.md) |  |  |

### Return type

[**OrderDetail**](OrderDetail.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: application/json, application/x-www-form-urlencoded, multipart/form-data
- **Accept**: application/json


## wallets_api_v1_wallet_balance_retrieve

> <WalletBalance> wallets_api_v1_wallet_balance_retrieve

دریافت موجودی کیف پول

<div dir=\"rtl\" style=\"text-align: right;\">  موجودی کیف پول فروشنده  ## توضیحات  این endpoint موجودی کیف پول فروشنده را برمی‌گرداند. کیف پول برای پرداخت هزینه ارسال دیجی‌اکسپرس استفاده می‌شود. هنگام ثبت مرسوله دیجی‌اکسپرس، هزینه ارسال به‌صورت خودکار از کیف پول کسر می‌شود.  نیاز به **API_KEY** فروشنده دارد.  </div> 

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::DefaultApi.new

begin
  # دریافت موجودی کیف پول
  result = api_instance.wallets_api_v1_wallet_balance_retrieve
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->wallets_api_v1_wallet_balance_retrieve: #{e}"
end
```

#### Using the wallets_api_v1_wallet_balance_retrieve_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<WalletBalance>, Integer, Hash)> wallets_api_v1_wallet_balance_retrieve_with_http_info

```ruby
begin
  # دریافت موجودی کیف پول
  data, status_code, headers = api_instance.wallets_api_v1_wallet_balance_retrieve_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <WalletBalance>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->wallets_api_v1_wallet_balance_retrieve_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**WalletBalance**](WalletBalance.md)

### Authorization

[MerchantAPIKeyAuth](../README.md#MerchantAPIKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

