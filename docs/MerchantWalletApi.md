# OpenapiClient::MerchantWalletApi

All URIs are relative to *https://bwdk-backend.digify.shop*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**wallets_api_v1_wallet_balance_retrieve**](MerchantWalletApi.md#wallets_api_v1_wallet_balance_retrieve) | **GET** /wallets/api/v1/wallet-balance/ | Get Wallet Balance |


## wallets_api_v1_wallet_balance_retrieve

> <WalletBalance> wallets_api_v1_wallet_balance_retrieve

Get Wallet Balance

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

api_instance = OpenapiClient::MerchantWalletApi.new

begin
  # Get Wallet Balance
  result = api_instance.wallets_api_v1_wallet_balance_retrieve
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantWalletApi->wallets_api_v1_wallet_balance_retrieve: #{e}"
end
```

#### Using the wallets_api_v1_wallet_balance_retrieve_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<WalletBalance>, Integer, Hash)> wallets_api_v1_wallet_balance_retrieve_with_http_info

```ruby
begin
  # Get Wallet Balance
  data, status_code, headers = api_instance.wallets_api_v1_wallet_balance_retrieve_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <WalletBalance>
rescue OpenapiClient::ApiError => e
  puts "Error when calling MerchantWalletApi->wallets_api_v1_wallet_balance_retrieve_with_http_info: #{e}"
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

