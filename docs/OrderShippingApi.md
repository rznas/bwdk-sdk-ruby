# OpenapiClient::OrderShippingApi

All URIs are relative to *https://bwdk-backend.digify.shop*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**order_api_v1_manager_cancel_shipment_create**](OrderShippingApi.md#order_api_v1_manager_cancel_shipment_create) | **POST** /order/api/v1/manager/{order_uuid}/cancel-shipment/ | Cancel Shipment |
| [**order_api_v1_manager_change_shipping_method_update**](OrderShippingApi.md#order_api_v1_manager_change_shipping_method_update) | **PUT** /order/api/v1/manager/{order_uuid}/change-shipping-method/ | Change Shipping Method |
| [**order_api_v1_manager_revive_shipment_create**](OrderShippingApi.md#order_api_v1_manager_revive_shipment_create) | **POST** /order/api/v1/manager/{order_uuid}/revive-shipment/ | Revive Shipment |


## order_api_v1_manager_cancel_shipment_create

> <MerchantOrderCancelShipmentResponse> order_api_v1_manager_cancel_shipment_create(order_uuid)

Cancel Shipment

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

api_instance = OpenapiClient::OrderShippingApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 

begin
  # Cancel Shipment
  result = api_instance.order_api_v1_manager_cancel_shipment_create(order_uuid)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling OrderShippingApi->order_api_v1_manager_cancel_shipment_create: #{e}"
end
```

#### Using the order_api_v1_manager_cancel_shipment_create_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<MerchantOrderCancelShipmentResponse>, Integer, Hash)> order_api_v1_manager_cancel_shipment_create_with_http_info(order_uuid)

```ruby
begin
  # Cancel Shipment
  data, status_code, headers = api_instance.order_api_v1_manager_cancel_shipment_create_with_http_info(order_uuid)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <MerchantOrderCancelShipmentResponse>
rescue OpenapiClient::ApiError => e
  puts "Error when calling OrderShippingApi->order_api_v1_manager_cancel_shipment_create_with_http_info: #{e}"
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

Change Shipping Method

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

api_instance = OpenapiClient::OrderShippingApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
order_detail = OpenapiClient::OrderDetail.new({id: 37, created_at: Time.now, order_uuid: 'order_uuid_example', reservation_expired_at: 37, merchant_order_id: 'merchant_order_id_example', status: OpenapiClient::OrderStatusEnum::N1, status_display: 'status_display_example', main_amount: 37, final_amount: 37, total_paid_amount: 37, discount_amount: 37, tax_amount: 37, shipping_amount: 37, loyalty_amount: 37, callback_url: 'callback_url_example', merchant: OpenapiClient::Merchant.new({domain: 'domain_example', logo: 'logo_example'}), items: [OpenapiClient::OrderItemCreate.new({name: 'name_example', count: 37, options: [OpenapiClient::Option.new({type_name: OpenapiClient::TypeNameEnum::COLOR, name: 'name_example', value: 'value_example'})]})], source_address: 3.56, destination_address: 3.56, selected_shipping_method: OpenapiClient::ShippingMethod.new({id: 37, name: 'name_example', get_shipping_type_display: 'get_shipping_type_display_example', shipping_type_display: 'shipping_type_display_example', delivery_time_display: 'delivery_time_display_example', delivery_time_range_display: OpenapiClient::DeliveryTimeRangeDisplay.new({min_date: 'min_date_example', max_date: 'max_date_example'}), inventory_address: OpenapiClient::BusinessAddress.new({id: 37, address: 'address_example', city_name: 'city_name_example', state_name: 'state_name_example', created_at: Time.now, modified_at: Time.now})}), shipping_selected_at: Time.now, address_selected_at: Time.now, packing_amount: 37, packing_selected_at: Time.now, selected_packing: OpenapiClient::Packing.new({id: 37, name: 'name_example'}), can_select_packing: false, can_select_shipping: false, can_select_address: false, can_proceed_to_payment: false, is_paid: false, user: OpenapiClient::OrderUser.new, payment: OpenapiClient::PaymentOrder.new({final_amount: 37, gateway_type: OpenapiClient::GatewayTypeEnum::N1, gateway_type_display: 'gateway_type_display_example', paid_at: 'paid_at_example', gateway_name: 'gateway_name_example', invoice_id: 'invoice_id_example', settlement_date: 'settlement_date_example', settlement_status: 37, settlement_status_display: 'settlement_status_display_example'}), preparation_time: 37, weight: 3.56, selected_shipping_data: { key: 3.56}, reference_code: 'reference_code_example', promotion_discount_amount: 3.56, promotion_data: { key: 3.56}, digipay_markup_amount: 37, markup_commission_percentage: 37, previous_status: OpenapiClient::OrderStatusEnum::N1, previous_status_display: 'previous_status_display_example'}) # OrderDetail | 

begin
  # Change Shipping Method
  result = api_instance.order_api_v1_manager_change_shipping_method_update(order_uuid, order_detail)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling OrderShippingApi->order_api_v1_manager_change_shipping_method_update: #{e}"
end
```

#### Using the order_api_v1_manager_change_shipping_method_update_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<OrderDetail>, Integer, Hash)> order_api_v1_manager_change_shipping_method_update_with_http_info(order_uuid, order_detail)

```ruby
begin
  # Change Shipping Method
  data, status_code, headers = api_instance.order_api_v1_manager_change_shipping_method_update_with_http_info(order_uuid, order_detail)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <OrderDetail>
rescue OpenapiClient::ApiError => e
  puts "Error when calling OrderShippingApi->order_api_v1_manager_change_shipping_method_update_with_http_info: #{e}"
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


## order_api_v1_manager_revive_shipment_create

> <MerchantOrderReviveShipmentResponse> order_api_v1_manager_revive_shipment_create(order_uuid, opts)

Revive Shipment

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

api_instance = OpenapiClient::OrderShippingApi.new
order_uuid = '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | 
opts = {
  revive_shipment: OpenapiClient::ReviveShipment.new # ReviveShipment | 
}

begin
  # Revive Shipment
  result = api_instance.order_api_v1_manager_revive_shipment_create(order_uuid, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling OrderShippingApi->order_api_v1_manager_revive_shipment_create: #{e}"
end
```

#### Using the order_api_v1_manager_revive_shipment_create_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<MerchantOrderReviveShipmentResponse>, Integer, Hash)> order_api_v1_manager_revive_shipment_create_with_http_info(order_uuid, opts)

```ruby
begin
  # Revive Shipment
  data, status_code, headers = api_instance.order_api_v1_manager_revive_shipment_create_with_http_info(order_uuid, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <MerchantOrderReviveShipmentResponse>
rescue OpenapiClient::ApiError => e
  puts "Error when calling OrderShippingApi->order_api_v1_manager_revive_shipment_create_with_http_info: #{e}"
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

