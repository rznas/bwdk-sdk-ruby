# OpenapiClient::SellerProfileManagementApi

All URIs are relative to *https://bwdk-backend.digify.shop*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**merchant_api_v1_auth_status_retrieve**](SellerProfileManagementApi.md#merchant_api_v1_auth_status_retrieve) | **GET** /merchant/api/v1/auth/status/ | وضعیت لاگین بودن |


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

api_instance = OpenapiClient::SellerProfileManagementApi.new

begin
  # وضعیت لاگین بودن
  result = api_instance.merchant_api_v1_auth_status_retrieve
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling SellerProfileManagementApi->merchant_api_v1_auth_status_retrieve: #{e}"
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
  puts "Error when calling SellerProfileManagementApi->merchant_api_v1_auth_status_retrieve_with_http_info: #{e}"
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

