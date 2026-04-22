# OpenapiClient::MerchantOrdersApi

All URIs are relative to *https://bwdk-backend.digify.shop*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**order_api_v1_create_order_create**](MerchantOrdersApi.md#order_api_v1_create_order_create) | **POST** /order/api/v1/create-order/ | ساخت سفارش |
| [**order_api_v1_manager_list**](MerchantOrdersApi.md#order_api_v1_manager_list) | **GET** /order/api/v1/manager/ | لیست سفارشات |
| [**order_api_v1_manager_paid_list**](MerchantOrdersApi.md#order_api_v1_manager_paid_list) | **GET** /order/api/v1/manager/paid/ | سفارش پرداخت‌شده و تایید‌نشده |
| [**order_api_v1_manager_refund_create**](MerchantOrdersApi.md#order_api_v1_manager_refund_create) | **POST** /order/api/v1/manager/{order_uuid}/refund/ | بازگشت سفارش |
| [**order_api_v1_manager_retrieve**](MerchantOrdersApi.md#order_api_v1_manager_retrieve) | **GET** /order/api/v1/manager/{order_uuid}/ | دریافت سفارش |
| [**order_api_v1_manager_update_status_update**](MerchantOrdersApi.md#order_api_v1_manager_update_status_update) | **PUT** /order/api/v1/manager/{order_uuid}/update-status/ | Update Order Status |
| [**order_api_v1_manager_verify_create**](MerchantOrdersApi.md#order_api_v1_manager_verify_create) | **POST** /order/api/v1/manager/{order_uuid}/verify/ | تایید سفارش |


## order_api_v1_create_order_create

> <OrderCreateResponse> order_api_v1_create_order_create(order_create)

ساخت سفارش

<div dir=\"rtl\" style=\"text-align: right;\">  ساخت سفارش جدید در سیستم BWDK  ## توضیحات  این endpoint برای ایجاد یک سفارش جدید در سیستم خرید با دیجی‌کالا استفاده می‌شود. در این درخواست باید اطلاعات سفارش، اقلام سبد خرید، و آدرس callback شامل شود.  برای شروع ارتباط با سرویس‌های **خرید با دیجی‌کالا** شما باید دارای **API_KEY** باشید که این مورد از سمت تیم دیجی‌فای در اختیار شما قرار خواهد گرفت.  ### روند کاری  **مرحله ۱: درخواست ساخت سفارش**  کاربر پس از انتخاب کالاهای خود در سبد خرید، بر روی دکمه **خرید با دیجی‌کالا** کلیک می‌کند و بک‌اند مرچنت درخواستی برای ساخت سفارش BWDK دریافت می‌کند. در این مرحله اولین درخواست خود را به بک‌اند BWDK ارسال می‌نمایید:  BWDK یک سفارش جدید برای مرچنت با وضعیت **INITIAL** ایجاد می‌کند و **order_uuid** را جنریت می‌کند. آدرس **order_start_url** نقطه شروع مسیر تکمیل سفارش است (انتخاب آدرس، شیپینگ، پکینگ، پرداخت و غیره).  **مرحله ۲: بررسی نهایی سفارش پیش از تأیید**  پس از اینکه مشتری فرآیند پرداخت را تکمیل کرد و به **callback_url** هدایت شد، بک‌اند مرچنت باید پیش از فراخوانی verify، یک‌بار سفارش را دریافت کرده و مبالغ نهایی (شامل هزینه کالاها، شیپینگ، تخفیف‌ها و جمع کل) را با اطلاعات سمت مرچنت تطبیق دهد تا از صحت تراکنش اطمینان حاصل شود.  **مرحله ۳: تأیید سفارش**  پس از تطبیق موفق مبالغ، درخواست verify ارسال می‌شود تا سفارش نهایی و آماده ارسال گردد. <br> </div>  ```mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API     participant C as مشتری     participant PG as درگاه پرداخت      M->>API: POST /api/v1/orders/create     Note over M,API: شناسه سفارش, کالاها, مبلغ, callback_url     API-->>M: {لینک شروع سفارش, شناسه سفارش}      M->>C: تغییر مسیر به لینک شروع      C->>API: تکمیل درخواست خرید توسط مشتری     API->>PG: شروع فرآیند پرداخت     PG-->>C: نتیجه پرداخت     PG->>API: تأیید پرداخت     API-->>C: تغییر مسیر به callback_url      M->>API: GET /api/v1/orders/manager/{uuid}     Note over M,API: بررسی نهایی مبالغ سفارش     API-->>M: اطلاعات سفارش (مبالغ، اقلام، وضعیت)      M->>API: POST /api/v1/orders/manager/{uuid}/verify     Note over M,API: {شناسه منحصربفرد فروشنده}     API-->>M: سفارش تأیید شد و آماده ارسال است ```  </div> 

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

api_instance = OpenapiClient::MerchantOrdersApi.new
order_create = OpenapiClient::OrderCreate.new({merchant_order_id: 'merchant_order_id_example', merchant_unique_id: 'merchant_unique_id_example', callback_url: 'callback_url_example', destination_address: 3.56, items: [OpenapiClient::OrderItemCreate.new({name: 'name_example', count: 37, options: [OpenapiClient::Option.new({type_name: OpenapiClient::TypeNameEnum::COLOR, name: 'name_example', value: 'value_example'})]})], user: 37, reference_code: 'reference_code_example'}) # OrderCreate | 

begin
  # ساخت سفارش
  result = api_instance.order_api_v1_create_order_create(order_create)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantOrdersApi->order_api_v1_create_order_create: #{e}"
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
  puts "Error when calling MerchantOrdersApi->order_api_v1_create_order_create_with_http_info: #{e}"
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

api_instance = OpenapiClient::MerchantOrdersApi.new
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
  status: 1, # Integer | * `1` - اولیه * `2` - شروع شده * `3` - در انتظار * `4` - در انتظار درگاه * `5` - منقضی شده * `6` - لغو شده * `7` - پرداخت‌شده توسط کاربر * `8` - پرداخت موفیت آمیز نبود * `9` - تأیید شده توسط فروشگاه * `10` - تأیید توسط فروشگاه ناموفق بود * `11` - ناموفق از سوی فروشگاه * `12` - لغوشده توسط فروشگاه * `13` - درخواست بازگشت وجه به مشتری به دلیل درخواست مشتری * `14` - درخواست بازگشت وجه به فروشگاه پس از عدم تأیید توسط فروشگاه * `15` - درخواست بازگشت وجه به مشتری پس از ناموفق بودن توسط فروشگاه * `16` - بازپرداخت به فروشگاه پس از لغو توسط فروشگاه * `17` - بازپرداخت تکمیل شد * `18` - زمان انقضا گذشته است * `19` - تحویل شده * `20` - جمع اوری شده و در حال ارسال
  statuses: 'statuses_example', # String | 
  today_pickup: true # Boolean | 
}

begin
  # لیست سفارشات
  result = api_instance.order_api_v1_manager_list(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_list: #{e}"
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
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_list_with_http_info: #{e}"
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
| **status** | **Integer** | * &#x60;1&#x60; - اولیه * &#x60;2&#x60; - شروع شده * &#x60;3&#x60; - در انتظار * &#x60;4&#x60; - در انتظار درگاه * &#x60;5&#x60; - منقضی شده * &#x60;6&#x60; - لغو شده * &#x60;7&#x60; - پرداخت‌شده توسط کاربر * &#x60;8&#x60; - پرداخت موفیت آمیز نبود * &#x60;9&#x60; - تأیید شده توسط فروشگاه * &#x60;10&#x60; - تأیید توسط فروشگاه ناموفق بود * &#x60;11&#x60; - ناموفق از سوی فروشگاه * &#x60;12&#x60; - لغوشده توسط فروشگاه * &#x60;13&#x60; - درخواست بازگشت وجه به مشتری به دلیل درخواست مشتری * &#x60;14&#x60; - درخواست بازگشت وجه به فروشگاه پس از عدم تأیید توسط فروشگاه * &#x60;15&#x60; - درخواست بازگشت وجه به مشتری پس از ناموفق بودن توسط فروشگاه * &#x60;16&#x60; - بازپرداخت به فروشگاه پس از لغو توسط فروشگاه * &#x60;17&#x60; - بازپرداخت تکمیل شد * &#x60;18&#x60; - زمان انقضا گذشته است * &#x60;19&#x60; - تحویل شده * &#x60;20&#x60; - جمع اوری شده و در حال ارسال | [optional] |
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

api_instance = OpenapiClient::MerchantOrdersApi.new
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
  status: 1, # Integer | * `1` - اولیه * `2` - شروع شده * `3` - در انتظار * `4` - در انتظار درگاه * `5` - منقضی شده * `6` - لغو شده * `7` - پرداخت‌شده توسط کاربر * `8` - پرداخت موفیت آمیز نبود * `9` - تأیید شده توسط فروشگاه * `10` - تأیید توسط فروشگاه ناموفق بود * `11` - ناموفق از سوی فروشگاه * `12` - لغوشده توسط فروشگاه * `13` - درخواست بازگشت وجه به مشتری به دلیل درخواست مشتری * `14` - درخواست بازگشت وجه به فروشگاه پس از عدم تأیید توسط فروشگاه * `15` - درخواست بازگشت وجه به مشتری پس از ناموفق بودن توسط فروشگاه * `16` - بازپرداخت به فروشگاه پس از لغو توسط فروشگاه * `17` - بازپرداخت تکمیل شد * `18` - زمان انقضا گذشته است * `19` - تحویل شده * `20` - جمع اوری شده و در حال ارسال
  statuses: 'statuses_example', # String | 
  today_pickup: true # Boolean | 
}

begin
  # سفارش پرداخت‌شده و تایید‌نشده
  result = api_instance.order_api_v1_manager_paid_list(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_paid_list: #{e}"
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
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_paid_list_with_http_info: #{e}"
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
| **status** | **Integer** | * &#x60;1&#x60; - اولیه * &#x60;2&#x60; - شروع شده * &#x60;3&#x60; - در انتظار * &#x60;4&#x60; - در انتظار درگاه * &#x60;5&#x60; - منقضی شده * &#x60;6&#x60; - لغو شده * &#x60;7&#x60; - پرداخت‌شده توسط کاربر * &#x60;8&#x60; - پرداخت موفیت آمیز نبود * &#x60;9&#x60; - تأیید شده توسط فروشگاه * &#x60;10&#x60; - تأیید توسط فروشگاه ناموفق بود * &#x60;11&#x60; - ناموفق از سوی فروشگاه * &#x60;12&#x60; - لغوشده توسط فروشگاه * &#x60;13&#x60; - درخواست بازگشت وجه به مشتری به دلیل درخواست مشتری * &#x60;14&#x60; - درخواست بازگشت وجه به فروشگاه پس از عدم تأیید توسط فروشگاه * &#x60;15&#x60; - درخواست بازگشت وجه به مشتری پس از ناموفق بودن توسط فروشگاه * &#x60;16&#x60; - بازپرداخت به فروشگاه پس از لغو توسط فروشگاه * &#x60;17&#x60; - بازپرداخت تکمیل شد * &#x60;18&#x60; - زمان انقضا گذشته است * &#x60;19&#x60; - تحویل شده * &#x60;20&#x60; - جمع اوری شده و در حال ارسال | [optional] |
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

api_instance = OpenapiClient::MerchantOrdersApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
opts = {
  refund_order: OpenapiClient::RefundOrder.new # RefundOrder | 
}

begin
  # بازگشت سفارش
  result = api_instance.order_api_v1_manager_refund_create(order_uuid, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_refund_create: #{e}"
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
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_refund_create_with_http_info: #{e}"
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

api_instance = OpenapiClient::MerchantOrdersApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 

begin
  # دریافت سفارش
  result = api_instance.order_api_v1_manager_retrieve(order_uuid)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_retrieve: #{e}"
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
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_retrieve_with_http_info: #{e}"
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


## order_api_v1_manager_update_status_update

> <OrderDetail> order_api_v1_manager_update_status_update(order_uuid, update_order_status)

Update Order Status

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

api_instance = OpenapiClient::MerchantOrdersApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
update_order_status = OpenapiClient::UpdateOrderStatus.new({status: OpenapiClient::OrderStatusEnum::N1}) # UpdateOrderStatus | 

begin
  # Update Order Status
  result = api_instance.order_api_v1_manager_update_status_update(order_uuid, update_order_status)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_update_status_update: #{e}"
end
```

#### Using the order_api_v1_manager_update_status_update_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<OrderDetail>, Integer, Hash)> order_api_v1_manager_update_status_update_with_http_info(order_uuid, update_order_status)

```ruby
begin
  # Update Order Status
  data, status_code, headers = api_instance.order_api_v1_manager_update_status_update_with_http_info(order_uuid, update_order_status)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <OrderDetail>
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_update_status_update_with_http_info: #{e}"
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

api_instance = OpenapiClient::MerchantOrdersApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
verify_order = OpenapiClient::VerifyOrder.new({merchant_unique_id: 'merchant_unique_id_example'}) # VerifyOrder | 

begin
  # تایید سفارش
  result = api_instance.order_api_v1_manager_verify_create(order_uuid, verify_order)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_verify_create: #{e}"
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
  puts "Error when calling MerchantOrdersApi->order_api_v1_manager_verify_create_with_http_info: #{e}"
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

