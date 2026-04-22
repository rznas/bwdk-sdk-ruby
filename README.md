# openapi_client

OpenapiClient - the Ruby gem for the BWDK API

<div dir=\"rtl\" style=\"text-align: right;\">

# مستندات فروشندگان در سرویس خرید با دیجی‌کالا

این پلتفرم برای فروشندگان (مرچنت‌ها) جهت یکپارچه‌سازی خدمات پرداخت و تجارت الکترونیکی با سیستم خرید با دیجی‌کالا.
شامل مدیریت سفارشات، ارسال، و احراز هویت فروشندگان است.


<div dir=\"rtl\" style=\"text-align: right;\">

<!-- ## توضیح وضعیت‌های سفارش

### ۱. INITIAL — ایجاد اولیه سفارش

**معنا:** سفارش توسط بک‌اند مرچنت ساخته شده ولی هنوز هیچ کاربری به آن اختصاص داده نشده است.

**چگونه اتفاق می‌افتد:** مرچنت با ارسال درخواست `POST /api/v1/orders/create` و ارائه اطلاعات کالاها، مبلغ و `callback_url`، یک سفارش جدید ایجاد می‌کند. BWDK یک `order_uuid` منحصربه‌فرد و لینک شروع سفارش (`order_start_url`) برمی‌گرداند.

**وابستگی‌ها:** نیازی به کاربر یا پرداخت ندارد. فقط اطلاعات کالا از سمت مرچنت کافی است.

---

### ۲. STARTED — آغاز جریان خرید

**معنا:** مشتری روی لینک شروع سفارش کلیک کرده و وارد محیط BWDK شده است، اما هنوز لاگین نکرده.

**چگونه اتفاق می‌افتد:** وقتی مشتری به `order_start_url` هدایت می‌شود، BWDK وضعیت سفارش را از `INITIAL` به `STARTED` تغییر می‌دهد. در این مرحله فرآیند احراز هویت (SSO) آغاز می‌شود.

**وابستگی‌ها:** مشتری باید به لینک شروع هدایت شده باشد.

---

### ۳. PENDING — انتظار برای تکمیل سفارش

**معنا:** مشتری با موفقیت وارد سیستم شده و سفارش به حساب او اختصاص یافته. مشتری در حال انتخاب آدرس، روش ارسال، بسته‌بندی یا تخفیف است.

**چگونه اتفاق می‌افتد:** پس از تکمیل ورود به سیستم (SSO)، BWDK سفارش را به کاربر وصل کرده و وضعیت را به `PENDING` تغییر می‌دهد.

**وابستگی‌ها:** ورود موفق کاربر به سیستم (SSO). در این مرحله مشتری می‌تواند آدرس، شیپینگ، پکینگ و تخفیف را انتخاب کند.

---

### ۴. WAITING_FOR_GATEWAY — انتظار برای پرداخت

**معنا:** مشتری اطلاعات سفارش را تأیید کرده و به درگاه پرداخت هدایت شده است.

**چگونه اتفاق می‌افتد:** مشتری دکمه «پرداخت» را می‌زند (`POST /api/v1/orders/submit`)، سیستم یک رکورد پرداخت ایجاد می‌کند و کاربر به درگاه Digipay هدایت می‌شود. وضعیت سفارش به `WAITING_FOR_GATEWAY` تغییر می‌کند.

**وابستگی‌ها:** انتخاب آدرس، روش ارسال و بسته‌بندی الزامی است. پرداخت باید ایجاد شده باشد.

---

### ۷. PAID_BY_USER — پرداخت موفق

**معنا:** تراکنش پرداخت با موفقیت انجام شده و وجه از حساب مشتری کسر شده است.

**چگونه اتفاق می‌افتد:** درگاه پرداخت نتیجه موفق را به BWDK اطلاع می‌دهد. سیستم پرداخت را تأیید و وضعیت سفارش را به `PAID_BY_USER` تغییر می‌دهد. در این لحظه مشتری به `callback_url` مرچنت هدایت می‌شود.

**وابستگی‌ها:** تأیید موفق تراکنش از سوی درگاه پرداخت (Digipay).

---

### ۹. VERIFIED_BY_MERCHANT — تأیید توسط مرچنت

**معنا:** مرچنت سفارش را بررسی کرده و موجودی کالا و صحت اطلاعات را تأیید نموده است. سفارش آماده ارسال است.

**چگونه اتفاق می‌افتد:** مرچنت با ارسال درخواست `POST /api/v1/orders/manager/{uuid}/verify` سفارش را تأیید می‌کند. این مرحله **اجباری** است و باید پس از پرداخت موفق انجام شود.

**وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد. مرچنت باید موجودی کالا را بررسی کند.

---

### ۲۰. SHIPPED — ارسال شد

**معنا:** سفارش از انبار خارج شده و در حال ارسال به مشتری است.

**چگونه اتفاق می‌افتد:** مرچنت پس از ارسال کالا، وضعیت سفارش را از طریق API به `SHIPPED` تغییر می‌دهد.

**وابستگی‌ها:** سفارش باید در وضعیت `VERIFIED_BY_MERCHANT` باشد.

---

### ۱۹. DELIVERED — تحویل داده شد

**معنا:** سفارش به دست مشتری رسیده و فرآیند خرید به پایان رسیده است.

**چگونه اتفاق می‌افتد:** مرچنت پس از تحویل موفق، وضعیت را به `DELIVERED` تغییر می‌دهد.

**وابستگی‌ها:** سفارش باید در وضعیت `SHIPPED` باشد.

---

### ۵. EXPIRED — منقضی شد

**معنا:** زمان رزرو سفارش به پایان رسیده و سفارش به صورت خودکار لغو شده است.

**چگونه اتفاق می‌افتد:** یک Task دوره‌ای به طور خودکار سفارش‌هایی که `reservation_expired_at` آن‌ها گذشته را پیدا کرده و وضعیتشان را به `EXPIRED` تغییر می‌دهد. این مکانیزم مانع بلوکه شدن موجودی کالا می‌شود.

**وابستگی‌ها:** سفارش باید در یکی از وضعیت‌های `INITIAL`، `STARTED`، `PENDING` یا `WAITING_FOR_GATEWAY` باشد و زمان رزرو آن گذشته باشد.

---

### ۱۸. EXPIRATION_TIME_EXCEEDED — زمان انقضا گذشت

**معنا:** در لحظه ثبت نهایی یا پرداخت، مشخص شد که زمان مجاز سفارش تمام شده است.

**چگونه اتفاق می‌افتد:** هنگام ارسال درخواست پرداخت (`submit_order`)، سیستم بررسی می‌کند که `expiration_time` سفارش هنوز معتبر است یا خیر. در صورت گذشتن زمان، وضعیت به `EXPIRATION_TIME_EXCEEDED` تغییر می‌کند.

**وابستگی‌ها:** سفارش در وضعیت `PENDING` یا `WAITING_FOR_GATEWAY` است و فیلد `expiration_time` سپری شده.

---

### ۶. CANCELLED — لغو توسط مشتری

**معنا:** مشتری در حین فرآیند خرید (قبل از پرداخت) سفارش را لغو کرده یا از صفحه خارج شده است.

**چگونه اتفاق می‌افتد:** مشتری در صفحه checkout دکمه «انصراف» را می‌زند یا پرداخت ناموفق بوده و سفارش به حالت لغو درمی‌آید.

**وابستگی‌ها:** سفارش باید در وضعیت `PENDING` یا `WAITING_FOR_GATEWAY` باشد. پرداختی انجام نشده است.

---

### ۸. FAILED_TO_PAY — پرداخت ناموفق

**معنا:** تراکنش پرداخت انجام نشد یا با خطا مواجه شد.

**چگونه اتفاق می‌افتد:** درگاه پرداخت نتیجه ناموفق برمی‌گرداند یا فرآیند بازگشت وجه در مرحله پرداخت با شکست مواجه می‌شود.

**وابستگی‌ها:** سفارش باید در وضعیت `WAITING_FOR_GATEWAY` بوده باشد.

---

### ۱۰. FAILED_TO_VERIFY_BY_MERCHANT — تأیید ناموفق توسط مرچنت

**معنا:** مرچنت سفارش را رد کرده است؛ معمولاً به دلیل ناموجود بودن کالا یا مغایرت اطلاعات.

**چگونه اتفاق می‌افتد:** مرچنت در پاسخ به درخواست verify، خطا برمی‌گرداند یا API آن وضعیت ناموفق تنظیم می‌کند. پس از این وضعیت، فرآیند استرداد وجه آغاز می‌شود.

**وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد.

---

### ۱۱. FAILED_BY_MERCHANT — خطا از سمت مرچنت

**معنا:** مرچنت پس از تأیید اولیه، اعلام می‌کند که قادر به انجام سفارش نیست (مثلاً به دلیل اتمام موجودی).

**چگونه اتفاق می‌افتد:** مرچنت وضعیت را به `FAILED_BY_MERCHANT` تغییر می‌دهد. وجه پرداختی مشتری مسترد خواهد شد.

**وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد.

---

### ۱۲. CANCELLED_BY_MERCHANT — لغو توسط مرچنت

**معنا:** مرچنت پس از پرداخت، سفارش را به هر دلیلی لغو کرده است.

**چگونه اتفاق می‌افتد:** مرچنت درخواست لغو سفارش را ارسال می‌کند. وجه پرداختی مشتری به او بازگردانده می‌شود.

**وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` یا `VERIFIED_BY_MERCHANT` باشد.

---

### ۱۳. REQUEST_TO_REFUND — درخواست استرداد توسط مشتری

**معنا:** مشتری درخواست بازگشت وجه داده و سیستم در حال پردازش استرداد است.

**چگونه اتفاق می‌افتد:** مرچنت از طریق API درخواست استرداد را ثبت می‌کند (`POST /api/v1/orders/manager/{uuid}/refund`). سفارش وارد صف پردازش استرداد می‌شود.

**وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` یا `VERIFIED_BY_MERCHANT` باشد.

---

### ۱۴، ۱۵، ۱۶. سایر وضعیت‌های درخواست استرداد

این وضعیت‌ها بر اساس دلیل استرداد از هم تفکیک می‌شوند:

- **۱۴ — REQUEST_TO_REFUND_TO_MERCHANT_AFTER_FAILED_TO_VERIFY:** استرداد پس از ناموفق بودن تأیید مرچنت؛ وجه به حساب مرچنت بازمی‌گردد.
- **۱۵ — REQUEST_TO_REFUND_TO_CUSTOMER_AFTER_FAILED_BY_MERCHANT:** استرداد پس از خطای مرچنت؛ وجه به مشتری بازمی‌گردد.
- **۱۶ — REQUEST_TO_REFUND_TO_MERCHANT_AFTER_CANCELLED_BY_MERCHANT:** استرداد پس از لغو توسط مرچنت؛ وجه به حساب مرچنت برمی‌گردد.

**چگونه اتفاق می‌افتد:** به صورت خودکار پس از رسیدن به وضعیت‌های ناموفق/لغو مربوطه توسط سیستم تنظیم می‌شود.

---

### ۱۷. REFUND_COMPLETED — استرداد تکمیل شد

**معنا:** وجه با موفقیت به صاحب آن (مشتری یا مرچنت بسته به نوع استرداد) بازگردانده شده است.

**چگونه اتفاق می‌افتد:** Task پردازش استرداد (`process_order_refund`) پس از تأیید موفق بازگشت وجه از سوی Digipay، وضعیت سفارش را به `REFUND_COMPLETED` تغییر می‌دهد.

**وابستگی‌ها:** یکی از وضعیت‌های درخواست استرداد (۱۳، ۱۴، ۱۵ یا ۱۶) باید فعال باشد و Digipay تراکنش استرداد را تأیید کرده باشد.
 -->
</div>


This SDK is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 1.0.0
- Package version: 1.0.0
- Generator version: 7.21.0
- Build package: org.openapitools.codegen.languages.RubyClientCodegen

## Installation

### Build a gem

To build the Ruby code into a gem:

```shell
gem build openapi_client.gemspec
```

Then either install the gem locally:

```shell
gem install ./openapi_client-1.0.0.gem
```

(for development, run `gem install --dev ./openapi_client-1.0.0.gem` to install the development dependencies)

or publish the gem to a gem hosting service, e.g. [RubyGems](https://rubygems.org/).

Finally add this to the Gemfile:

    gem 'openapi_client', '~> 1.0.0'

### Install from Git

If the Ruby gem is hosted at a git repository: https://github.com/GIT_USER_ID/GIT_REPO_ID, then add the following in the Gemfile:

    gem 'openapi_client', :git => 'https://github.com/GIT_USER_ID/GIT_REPO_ID.git'

### Include the Ruby code directly

Include the Ruby code directly using `-I` as follows:

```shell
ruby -Ilib script.rb
```

## Getting Started

Please follow the [installation](#installation) procedure and then run the following code:

```ruby
# Load the gem
require 'openapi_client'

# Setup authorization
OpenapiClient.configure do |config|
  # Configure API key authorization: MerchantAPIKeyAuth
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::MerchantOrdersApi.new
order_create = OpenapiClient::OrderCreate.new({merchant_order_id: 'merchant_order_id_example', merchant_unique_id: 'merchant_unique_id_example', callback_url: 'callback_url_example', destination_address: 3.56, items: [OpenapiClient::OrderItemCreate.new({name: 'name_example', count: 37, options: [OpenapiClient::Option.new({type_name: OpenapiClient::TypeNameEnum::COLOR, name: 'name_example', value: 'value_example'})]})], user: 37, reference_code: 'reference_code_example'}) # OrderCreate | 

begin
  #ساخت سفارش
  result = api_instance.order_api_v1_create_order_create(order_create)
  p result
rescue OpenapiClient::ApiError => e
  puts "Exception when calling MerchantOrdersApi->order_api_v1_create_order_create: #{e}"
end

```

## Documentation for API Endpoints

All URIs are relative to *https://bwdk-backend.digify.shop*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*OpenapiClient::MerchantOrdersApi* | [**order_api_v1_create_order_create**](docs/MerchantOrdersApi.md#order_api_v1_create_order_create) | **POST** /order/api/v1/create-order/ | ساخت سفارش
*OpenapiClient::MerchantOrdersApi* | [**order_api_v1_manager_list**](docs/MerchantOrdersApi.md#order_api_v1_manager_list) | **GET** /order/api/v1/manager/ | لیست سفارشات
*OpenapiClient::MerchantOrdersApi* | [**order_api_v1_manager_paid_list**](docs/MerchantOrdersApi.md#order_api_v1_manager_paid_list) | **GET** /order/api/v1/manager/paid/ | سفارش پرداخت‌شده و تایید‌نشده
*OpenapiClient::MerchantOrdersApi* | [**order_api_v1_manager_refund_create**](docs/MerchantOrdersApi.md#order_api_v1_manager_refund_create) | **POST** /order/api/v1/manager/{order_uuid}/refund/ | بازگشت سفارش
*OpenapiClient::MerchantOrdersApi* | [**order_api_v1_manager_retrieve**](docs/MerchantOrdersApi.md#order_api_v1_manager_retrieve) | **GET** /order/api/v1/manager/{order_uuid}/ | دریافت سفارش
*OpenapiClient::MerchantOrdersApi* | [**order_api_v1_manager_update_status_update**](docs/MerchantOrdersApi.md#order_api_v1_manager_update_status_update) | **PUT** /order/api/v1/manager/{order_uuid}/update-status/ | Update Order Status
*OpenapiClient::MerchantOrdersApi* | [**order_api_v1_manager_verify_create**](docs/MerchantOrdersApi.md#order_api_v1_manager_verify_create) | **POST** /order/api/v1/manager/{order_uuid}/verify/ | تایید سفارش
*OpenapiClient::MerchantWalletApi* | [**wallets_api_v1_wallet_balance_retrieve**](docs/MerchantWalletApi.md#wallets_api_v1_wallet_balance_retrieve) | **GET** /wallets/api/v1/wallet-balance/ | Get Wallet Balance
*OpenapiClient::OrderShippingApi* | [**order_api_v1_manager_cancel_shipment_create**](docs/OrderShippingApi.md#order_api_v1_manager_cancel_shipment_create) | **POST** /order/api/v1/manager/{order_uuid}/cancel-shipment/ | Cancel Shipment
*OpenapiClient::OrderShippingApi* | [**order_api_v1_manager_change_shipping_method_update**](docs/OrderShippingApi.md#order_api_v1_manager_change_shipping_method_update) | **PUT** /order/api/v1/manager/{order_uuid}/change-shipping-method/ | Change Shipping Method
*OpenapiClient::OrderShippingApi* | [**order_api_v1_manager_revive_shipment_create**](docs/OrderShippingApi.md#order_api_v1_manager_revive_shipment_create) | **POST** /order/api/v1/manager/{order_uuid}/revive-shipment/ | Revive Shipment
*OpenapiClient::SellerProfileManagementApi* | [**merchant_api_v1_auth_status_retrieve**](docs/SellerProfileManagementApi.md#merchant_api_v1_auth_status_retrieve) | **GET** /merchant/api/v1/auth/status/ | وضعیت لاگین بودن


## Documentation for Models

 - [OpenapiClient::AuthStatusResponse](docs/AuthStatusResponse.md)
 - [OpenapiClient::BusinessAddress](docs/BusinessAddress.md)
 - [OpenapiClient::DeliveryTimeRangeDisplay](docs/DeliveryTimeRangeDisplay.md)
 - [OpenapiClient::ErrorEnum](docs/ErrorEnum.md)
 - [OpenapiClient::GatewayTypeEnum](docs/GatewayTypeEnum.md)
 - [OpenapiClient::Merchant](docs/Merchant.md)
 - [OpenapiClient::MerchantOrderCancelShipmentResponse](docs/MerchantOrderCancelShipmentResponse.md)
 - [OpenapiClient::MerchantOrderRefundResponse](docs/MerchantOrderRefundResponse.md)
 - [OpenapiClient::MerchantOrderReviveShipmentResponse](docs/MerchantOrderReviveShipmentResponse.md)
 - [OpenapiClient::MerchantPaidOrderList](docs/MerchantPaidOrderList.md)
 - [OpenapiClient::NullEnum](docs/NullEnum.md)
 - [OpenapiClient::Option](docs/Option.md)
 - [OpenapiClient::OrderCreate](docs/OrderCreate.md)
 - [OpenapiClient::OrderCreateResponse](docs/OrderCreateResponse.md)
 - [OpenapiClient::OrderDetail](docs/OrderDetail.md)
 - [OpenapiClient::OrderError](docs/OrderError.md)
 - [OpenapiClient::OrderItemCreate](docs/OrderItemCreate.md)
 - [OpenapiClient::OrderStatusEnum](docs/OrderStatusEnum.md)
 - [OpenapiClient::OrderUser](docs/OrderUser.md)
 - [OpenapiClient::Packing](docs/Packing.md)
 - [OpenapiClient::PaginatedMerchantPaidOrderListList](docs/PaginatedMerchantPaidOrderListList.md)
 - [OpenapiClient::PaginatedOrderDetailList](docs/PaginatedOrderDetailList.md)
 - [OpenapiClient::PaymentOrder](docs/PaymentOrder.md)
 - [OpenapiClient::RefundOrder](docs/RefundOrder.md)
 - [OpenapiClient::ReviveShipment](docs/ReviveShipment.md)
 - [OpenapiClient::ShippingMethod](docs/ShippingMethod.md)
 - [OpenapiClient::ShippingTypeEnum](docs/ShippingTypeEnum.md)
 - [OpenapiClient::TypeNameEnum](docs/TypeNameEnum.md)
 - [OpenapiClient::UpdateOrderStatus](docs/UpdateOrderStatus.md)
 - [OpenapiClient::VerifyOrder](docs/VerifyOrder.md)
 - [OpenapiClient::WalletBalance](docs/WalletBalance.md)


## Documentation for Authorization


Authentication schemes defined for the API:
### MerchantAPIKeyAuth


- **Type**: API key
- **API key parameter name**: Authorization
- **Location**: HTTP header

