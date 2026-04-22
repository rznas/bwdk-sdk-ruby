=begin
#BWDK API

#<div dir=\"rtl\" style=\"text-align: right;\">  # مستندات فروشندگان در سرویس خرید با دیجی‌کالا  این پلتفرم برای فروشندگان (مرچنت‌ها) جهت یکپارچه‌سازی خدمات پرداخت و تجارت الکترونیکی با سیستم خرید با دیجی‌کالا. شامل مدیریت سفارشات، ارسال، و احراز هویت فروشندگان است.     ```mermaid flowchart TD     START([شروع]) --> INITIAL      INITIAL[\"1️⃣ INITIAL\\nسفارش ایجاد شد\"]     STARTED[\"2️⃣ STARTED\\nمشتری به BWDK هدایت شد\"]     PENDING[\"3️⃣ PENDING\\nمشتری وارد شد و سفارش در انتظار پرداخت\"]     WAITING_FOR_GATEWAY[\"4️⃣ WAITING_FOR_GATEWAY\\nمشتری به درگاه پرداخت هدایت شد\"]     PAID_BY_USER[\"7️⃣ PAID_BY_USER\\nپرداخت موفق\"]     VERIFIED_BY_MERCHANT[\"9️⃣ VERIFIED_BY_MERCHANT\\nتأیید شده توسط فروشنده\"]     SHIPPED[\"🚚 SHIPPED\\nارسال شد\"]     DELIVERED[\"✅ DELIVERED\\nتحویل داده شد\"]      EXPIRED[\"⏰ EXPIRED\\nمنقضی شد\"]     EXPIRATION_TIME_EXCEEDED[\"⏱️ EXPIRATION_TIME_EXCEEDED\\nزمان انقضا گذشت\"]     CANCELLED[\"❌ CANCELLED\\nلغو توسط مشتری\"]     FAILED_TO_PAY[\"💳 FAILED_TO_PAY\\nپرداخت ناموفق\"]     FAILED_TO_VERIFY_BY_MERCHANT[\"🔴 FAILED_TO_VERIFY_BY_MERCHANT\\nتأیید مرچنت ناموفق\"]     FAILED_BY_MERCHANT[\"🔴 FAILED_BY_MERCHANT\\nخطا از سمت مرچنت\"]     CANCELLED_BY_MERCHANT[\"🔴 CANCELLED_BY_MERCHANT\\nلغو توسط مرچنت\"]      R_CUSTOMER_REQUEST[\"1️⃣3️⃣ REQUEST_TO_REFUND\\nدرخواست استرداد توسط مشتری\"]     R_FAILED_VERIFY[\"1️⃣4️⃣ REQUEST_TO_REFUND\\nاسترداد پس از تأیید ناموفق مرچنت\"]     R_FAILED_MERCHANT[\"1️⃣5️⃣ REQUEST_TO_REFUND\\nاسترداد پس از خطای مرچنت\"]     R_CANCELLED_MERCHANT[\"1️⃣6️⃣ REQUEST_TO_REFUND\\nاسترداد پس از لغو مرچنت\"]     REFUND_COMPLETED[\"✅ REFUND_COMPLETED\\nاسترداد تکمیل شد\"]      INITIAL -->|\"مرچنت سفارش ایجاد کرد\"| STARTED     STARTED -->|\"مشتری وارد سیستم شد\"| PENDING     PENDING -->|\"مشتری سفارش را نهایی و ثبت کرد\"| WAITING_FOR_GATEWAY     WAITING_FOR_GATEWAY -->|\"پرداخت با موفقیت انجام شد\"| PAID_BY_USER     PAID_BY_USER -->|\"مرچنت سفارش را تأیید کرد\"| VERIFIED_BY_MERCHANT     VERIFIED_BY_MERCHANT -->|\"مرچنت وضعیت را به ارسال تغییر داد\"| SHIPPED     SHIPPED -->|\"مرچنت تحویل را تأیید کرد\"| DELIVERED      INITIAL -->|\"زمان رزرو به پایان رسید\"| EXPIRED     STARTED -->|\"زمان رزرو به پایان رسید\"| EXPIRED     PENDING -->|\"زمان رزرو به پایان رسید\"| EXPIRED     WAITING_FOR_GATEWAY -->|\"زمان رزرو به پایان رسید\"| EXPIRED      PENDING -->|\"زمان مجاز سفارش سپری شده بود\"| EXPIRATION_TIME_EXCEEDED     WAITING_FOR_GATEWAY -->|\"زمان مجاز سفارش سپری شده بود\"| EXPIRATION_TIME_EXCEEDED      PENDING -->|\"مشتری انصراف داد\"| CANCELLED     WAITING_FOR_GATEWAY -->|\"مشتری انصراف داد\"| CANCELLED      WAITING_FOR_GATEWAY -->|\"پرداخت ناموفق بود\"| FAILED_TO_PAY      PAID_BY_USER -->|\"مرچنت تأیید را رد کرد\"| FAILED_TO_VERIFY_BY_MERCHANT     PAID_BY_USER -->|\"مرچنت اعلام ناتوانی در انجام سفارش کرد\"| FAILED_BY_MERCHANT     PAID_BY_USER -->|\"مرچنت سفارش را لغو کرد\"| CANCELLED_BY_MERCHANT     VERIFIED_BY_MERCHANT -->|\"مرچنت سفارش را لغو کرد\"| CANCELLED_BY_MERCHANT      PAID_BY_USER -->|\"مرچنت درخواست استرداد داد\"| R_CUSTOMER_REQUEST     VERIFIED_BY_MERCHANT -->|\"مرچنت درخواست استرداد داد\"| R_CUSTOMER_REQUEST     FAILED_TO_VERIFY_BY_MERCHANT -->|\"سیستم استرداد را آغاز کرد\"| R_FAILED_VERIFY     FAILED_BY_MERCHANT -->|\"سیستم استرداد را آغاز کرد\"| R_FAILED_MERCHANT     CANCELLED_BY_MERCHANT -->|\"سیستم استرداد را آغاز کرد\"| R_CANCELLED_MERCHANT      R_CUSTOMER_REQUEST -->|\"استرداد توسط دیجی‌پی تأیید شد\"| REFUND_COMPLETED     R_FAILED_VERIFY -->|\"استرداد توسط دیجی‌پی تأیید شد\"| REFUND_COMPLETED     R_FAILED_MERCHANT -->|\"استرداد توسط دیجی‌پی تأیید شد\"| REFUND_COMPLETED     R_CANCELLED_MERCHANT -->|\"استرداد توسط دیجی‌پی تأیید شد\"| REFUND_COMPLETED      style INITIAL fill:#9e9e9e,color:#fff     style STARTED fill:#1565c0,color:#fff     style PENDING fill:#ef6c00,color:#fff     style WAITING_FOR_GATEWAY fill:#6a1b9a,color:#fff     style PAID_BY_USER fill:#2e7d32,color:#fff     style VERIFIED_BY_MERCHANT fill:#1b5e20,color:#fff     style SHIPPED fill:#0277bd,color:#fff     style DELIVERED fill:#1b5e20,color:#fff     style EXPIRED fill:#b71c1c,color:#fff     style EXPIRATION_TIME_EXCEEDED fill:#b71c1c,color:#fff     style CANCELLED fill:#7f0000,color:#fff     style FAILED_TO_PAY fill:#b71c1c,color:#fff     style FAILED_TO_VERIFY_BY_MERCHANT fill:#b71c1c,color:#fff     style FAILED_BY_MERCHANT fill:#b71c1c,color:#fff     style CANCELLED_BY_MERCHANT fill:#7f0000,color:#fff     style R_CUSTOMER_REQUEST fill:#e65100,color:#fff     style R_FAILED_VERIFY fill:#e65100,color:#fff     style R_FAILED_MERCHANT fill:#e65100,color:#fff     style R_CANCELLED_MERCHANT fill:#e65100,color:#fff     style REFUND_COMPLETED fill:#2e7d32,color:#fff ```  ---  <div dir=\"rtl\" style=\"text-align: right;\">  ## توضیح وضعیت‌های سفارش  ### ۱. INITIAL — ایجاد اولیه سفارش  **معنا:** سفارش توسط بک‌اند مرچنت ساخته شده ولی هنوز هیچ کاربری به آن اختصاص داده نشده است.  **چگونه اتفاق می‌افتد:** مرچنت با ارسال درخواست `POST /api/v1/orders/create` و ارائه اطلاعات کالاها، مبلغ و `callback_url`، یک سفارش جدید ایجاد می‌کند. BWDK یک `order_uuid` منحصربه‌فرد و لینک شروع سفارش (`order_start_url`) برمی‌گرداند.  **وابستگی‌ها:** نیازی به کاربر یا پرداخت ندارد. فقط اطلاعات کالا از سمت مرچنت کافی است.  ---  ### ۲. STARTED — آغاز جریان خرید  **معنا:** مشتری روی لینک شروع سفارش کلیک کرده و وارد محیط BWDK شده است، اما هنوز لاگین نکرده.  **چگونه اتفاق می‌افتد:** وقتی مشتری به `order_start_url` هدایت می‌شود، BWDK وضعیت سفارش را از `INITIAL` به `STARTED` تغییر می‌دهد. در این مرحله فرآیند احراز هویت (SSO) آغاز می‌شود.  **وابستگی‌ها:** مشتری باید به لینک شروع هدایت شده باشد.  ---  ### ۳. PENDING — انتظار برای تکمیل سفارش  **معنا:** مشتری با موفقیت وارد سیستم شده و سفارش به حساب او اختصاص یافته. مشتری در حال انتخاب آدرس، روش ارسال، بسته‌بندی یا تخفیف است.  **چگونه اتفاق می‌افتد:** پس از تکمیل ورود به سیستم (SSO)، BWDK سفارش را به کاربر وصل کرده و وضعیت را به `PENDING` تغییر می‌دهد.  **وابستگی‌ها:** ورود موفق کاربر به سیستم (SSO). در این مرحله مشتری می‌تواند آدرس، شیپینگ، پکینگ و تخفیف را انتخاب کند.  ---  ### ۴. WAITING_FOR_GATEWAY — انتظار برای پرداخت  **معنا:** مشتری اطلاعات سفارش را تأیید کرده و به درگاه پرداخت هدایت شده است.  **چگونه اتفاق می‌افتد:** مشتری دکمه «پرداخت» را می‌زند (`POST /api/v1/orders/submit`)، سیستم یک رکورد پرداخت ایجاد می‌کند و کاربر به درگاه Digipay هدایت می‌شود. وضعیت سفارش به `WAITING_FOR_GATEWAY` تغییر می‌کند.  **وابستگی‌ها:** انتخاب آدرس، روش ارسال و بسته‌بندی الزامی است. پرداخت باید ایجاد شده باشد.  ---  ### ۷. PAID_BY_USER — پرداخت موفق  **معنا:** تراکنش پرداخت با موفقیت انجام شده و وجه از حساب مشتری کسر شده است.  **چگونه اتفاق می‌افتد:** درگاه پرداخت نتیجه موفق را به BWDK اطلاع می‌دهد. سیستم پرداخت را تأیید و وضعیت سفارش را به `PAID_BY_USER` تغییر می‌دهد. در این لحظه مشتری به `callback_url` مرچنت هدایت می‌شود.  **وابستگی‌ها:** تأیید موفق تراکنش از سوی درگاه پرداخت (Digipay).  ---  ### ۹. VERIFIED_BY_MERCHANT — تأیید توسط مرچنت  **معنا:** مرچنت سفارش را بررسی کرده و موجودی کالا و صحت اطلاعات را تأیید نموده است. سفارش آماده ارسال است.  **چگونه اتفاق می‌افتد:** مرچنت با ارسال درخواست `POST /api/v1/orders/manager/{uuid}/verify` سفارش را تأیید می‌کند. این مرحله **اجباری** است و باید پس از پرداخت موفق انجام شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد. مرچنت باید موجودی کالا را بررسی کند.  ---  ### ۲۰. SHIPPED — ارسال شد  **معنا:** سفارش از انبار خارج شده و در حال ارسال به مشتری است.  **چگونه اتفاق می‌افتد:** مرچنت پس از ارسال کالا، وضعیت سفارش را از طریق API به `SHIPPED` تغییر می‌دهد.  **وابستگی‌ها:** سفارش باید در وضعیت `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۹. DELIVERED — تحویل داده شد  **معنا:** سفارش به دست مشتری رسیده و فرآیند خرید به پایان رسیده است.  **چگونه اتفاق می‌افتد:** مرچنت پس از تحویل موفق، وضعیت را به `DELIVERED` تغییر می‌دهد.  **وابستگی‌ها:** سفارش باید در وضعیت `SHIPPED` باشد.  ---  ### ۵. EXPIRED — منقضی شد  **معنا:** زمان رزرو سفارش به پایان رسیده و سفارش به صورت خودکار لغو شده است.  **چگونه اتفاق می‌افتد:** یک Task دوره‌ای به طور خودکار سفارش‌هایی که `reservation_expired_at` آن‌ها گذشته را پیدا کرده و وضعیتشان را به `EXPIRED` تغییر می‌دهد. این مکانیزم مانع بلوکه شدن موجودی کالا می‌شود.  **وابستگی‌ها:** سفارش باید در یکی از وضعیت‌های `INITIAL`، `STARTED`، `PENDING` یا `WAITING_FOR_GATEWAY` باشد و زمان رزرو آن گذشته باشد.  ---  ### ۱۸. EXPIRATION_TIME_EXCEEDED — زمان انقضا گذشت  **معنا:** در لحظه ثبت نهایی یا پرداخت، مشخص شد که زمان مجاز سفارش تمام شده است.  **چگونه اتفاق می‌افتد:** هنگام ارسال درخواست پرداخت (`submit_order`)، سیستم بررسی می‌کند که `expiration_time` سفارش هنوز معتبر است یا خیر. در صورت گذشتن زمان، وضعیت به `EXPIRATION_TIME_EXCEEDED` تغییر می‌کند.  **وابستگی‌ها:** سفارش در وضعیت `PENDING` یا `WAITING_FOR_GATEWAY` است و فیلد `expiration_time` سپری شده.  ---  ### ۶. CANCELLED — لغو توسط مشتری  **معنا:** مشتری در حین فرآیند خرید (قبل از پرداخت) سفارش را لغو کرده یا از صفحه خارج شده است.  **چگونه اتفاق می‌افتد:** مشتری در صفحه checkout دکمه «انصراف» را می‌زند یا پرداخت ناموفق بوده و سفارش به حالت لغو درمی‌آید.  **وابستگی‌ها:** سفارش باید در وضعیت `PENDING` یا `WAITING_FOR_GATEWAY` باشد. پرداختی انجام نشده است.  ---  ### ۸. FAILED_TO_PAY — پرداخت ناموفق  **معنا:** تراکنش پرداخت انجام نشد یا با خطا مواجه شد.  **چگونه اتفاق می‌افتد:** درگاه پرداخت نتیجه ناموفق برمی‌گرداند یا فرآیند بازگشت وجه در مرحله پرداخت با شکست مواجه می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `WAITING_FOR_GATEWAY` بوده باشد.  ---  ### ۱۰. FAILED_TO_VERIFY_BY_MERCHANT — تأیید ناموفق توسط مرچنت  **معنا:** مرچنت سفارش را رد کرده است؛ معمولاً به دلیل ناموجود بودن کالا یا مغایرت اطلاعات.  **چگونه اتفاق می‌افتد:** مرچنت در پاسخ به درخواست verify، خطا برمی‌گرداند یا API آن وضعیت ناموفق تنظیم می‌کند. پس از این وضعیت، فرآیند استرداد وجه آغاز می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد.  ---  ### ۱۱. FAILED_BY_MERCHANT — خطا از سمت مرچنت  **معنا:** مرچنت پس از تأیید اولیه، اعلام می‌کند که قادر به انجام سفارش نیست (مثلاً به دلیل اتمام موجودی).  **چگونه اتفاق می‌افتد:** مرچنت وضعیت را به `FAILED_BY_MERCHANT` تغییر می‌دهد. وجه پرداختی مشتری مسترد خواهد شد.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد.  ---  ### ۱۲. CANCELLED_BY_MERCHANT — لغو توسط مرچنت  **معنا:** مرچنت پس از پرداخت، سفارش را به هر دلیلی لغو کرده است.  **چگونه اتفاق می‌افتد:** مرچنت درخواست لغو سفارش را ارسال می‌کند. وجه پرداختی مشتری به او بازگردانده می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` یا `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۳. REQUEST_TO_REFUND — درخواست استرداد توسط مشتری  **معنا:** مشتری درخواست بازگشت وجه داده و سیستم در حال پردازش استرداد است.  **چگونه اتفاق می‌افتد:** مرچنت از طریق API درخواست استرداد را ثبت می‌کند (`POST /api/v1/orders/manager/{uuid}/refund`). سفارش وارد صف پردازش استرداد می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` یا `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۴، ۱۵، ۱۶. سایر وضعیت‌های درخواست استرداد  این وضعیت‌ها بر اساس دلیل استرداد از هم تفکیک می‌شوند:  - **۱۴ — REQUEST_TO_REFUND_TO_MERCHANT_AFTER_FAILED_TO_VERIFY:** استرداد پس از ناموفق بودن تأیید مرچنت؛ وجه به حساب مرچنت بازمی‌گردد. - **۱۵ — REQUEST_TO_REFUND_TO_CUSTOMER_AFTER_FAILED_BY_MERCHANT:** استرداد پس از خطای مرچنت؛ وجه به مشتری بازمی‌گردد. - **۱۶ — REQUEST_TO_REFUND_TO_MERCHANT_AFTER_CANCELLED_BY_MERCHANT:** استرداد پس از لغو توسط مرچنت؛ وجه به حساب مرچنت برمی‌گردد.  **چگونه اتفاق می‌افتد:** به صورت خودکار پس از رسیدن به وضعیت‌های ناموفق/لغو مربوطه توسط سیستم تنظیم می‌شود.  ---  ### ۱۷. REFUND_COMPLETED — استرداد تکمیل شد  **معنا:** وجه با موفقیت به صاحب آن (مشتری یا مرچنت بسته به نوع استرداد) بازگردانده شده است.  **چگونه اتفاق می‌افتد:** Task پردازش استرداد (`process_order_refund`) پس از تأیید موفق بازگشت وجه از سوی Digipay، وضعیت سفارش را به `REFUND_COMPLETED` تغییر می‌دهد.  **وابستگی‌ها:** یکی از وضعیت‌های درخواست استرداد (۱۳، ۱۴، ۱۵ یا ۱۶) باید فعال باشد و Digipay تراکنش استرداد را تأیید کرده باشد.  </div> 

The version of the OpenAPI document: 1.0.0

Generated by: https://openapi-generator.tech
Generator version: 7.21.0

=end

require 'spec_helper'
require 'json'

# Unit tests for OpenapiClient::DefaultApi
# Automatically generated by openapi-generator (https://openapi-generator.tech)
# Please update as you see appropriate
describe 'DefaultApi' do
  before do
    # run before each test
    @api_instance = OpenapiClient::DefaultApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of DefaultApi' do
    it 'should create an instance of DefaultApi' do
      expect(@api_instance).to be_instance_of(OpenapiClient::DefaultApi)
    end
  end

  # unit tests for merchant_api_v1_auth_status_retrieve
  # وضعیت لاگین بودن
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  بررسی وضعیت احراز هویت فروشنده  ## توضیحات  این endpoint برای بررسی اعتبار **API_KEY** فروشنده استفاده می‌شود. اگر کلید معتبر باشد، پاسخ &#x60;is_authenticated: true&#x60; برمی‌گردد. از این endpoint برای تأیید صحت کلید API قبل از شروع عملیات استفاده کنید.  نیاز به **API_KEY** فروشنده دارد (فقط Header لازم است، بدنه درخواست ندارد).  &lt;/div&gt; 
  # @param [Hash] opts the optional parameters
  # @return [AuthStatusResponse]
  describe 'merchant_api_v1_auth_status_retrieve test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_create_order_create
  # ساخت سفارش
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  ساخت سفارش جدید در سیستم BWDK  ## توضیحات  این endpoint برای ایجاد یک سفارش جدید در سیستم خرید با دیجی‌کالا استفاده می‌شود. در این درخواست باید اطلاعات سفارش، اقلام سبد خرید، و آدرس callback شامل شود.  برای شروع ارتباط با سرویس‌های **خرید با دیجی‌کالا** شما باید دارای **API_KEY** باشید که این مورد از سمت تیم دیجی‌فای در اختیار شما قرار خواهد گرفت.  ### روند کاری  **مرحله ۱: درخواست ساخت سفارش**  کاربر پس از انتخاب کالاهای خود در سبد خرید، بر روی دکمه **خرید با دیجی‌کالا** کلیک می‌کند و بک‌اند مرچنت درخواستی برای ساخت سفارش BWDK دریافت می‌کند. در این مرحله اولین درخواست خود را به بک‌اند BWDK ارسال می‌نمایید:  BWDK یک سفارش جدید برای مرچنت با وضعیت **INITIAL** ایجاد می‌کند و **order_uuid** را جنریت می‌کند. آدرس **order_start_url** نقطه شروع مسیر تکمیل سفارش است (انتخاب آدرس، شیپینگ، پکینگ، پرداخت و غیره). &lt;br&gt; &lt;/div&gt;  &#x60;&#x60;&#x60;mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API     participant C as مشتری     participant PG as درگاه پرداخت      M-&gt;&gt;API: POST /api/v1/orders/create     Note over M,API: شناسه سفارش, کالاها, مبلغ, callback_url     API--&gt;&gt;M: {لینک شروع سفارش, شناسه سفارش}      M-&gt;&gt;C: تغییر مسیر به لینک شروع      C-&gt;&gt;API: تکمیل درخواست خرید توسط مشتری     API-&gt;&gt;PG: شروع فرآیند پرداخت     PG--&gt;&gt;C: نتیجه پرداخت     PG-&gt;&gt;API: تأیید پرداخت     API--&gt;&gt;C: تغییر مسیر به callback_url      M-&gt;&gt;API: POST /api/v1/orders/manager/{uuid}/verify     Note over M,API: {شناسه منحصربفرد فروشنده}     API--&gt;&gt;M: سفارش تأیید شد و آماده ارسال است &#x60;&#x60;&#x60;  &lt;/div&gt; 
  # @param order_create 
  # @param [Hash] opts the optional parameters
  # @return [OrderCreateResponse]
  describe 'order_api_v1_create_order_create test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_cancel_shipment_create
  # لغو ارسال سفارش
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  لغو مرسوله دیجی‌اکسپرس  ## توضیحات  این endpoint برای لغو یک مرسوله ثبت‌شده در سرویس دیجی‌اکسپرس استفاده می‌شود. پس از لغو موفق، مرسوله از صف ارسال خارج می‌شود.  نیاز به **API_KEY** فروشنده دارد.  ## شرایط لغو  * سفارش باید دارای روش ارسال **DigiExpress** باشد * مرسوله باید در وضعیت **در انتظار تحویل به پیک** (Request for Pickup) باشد  &lt;/div&gt;  &#x60;&#x60;&#x60;mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API     participant DX as دیجی‌اکسپرس      M-&gt;&gt;API: POST /order/api/v1/manager/{order_uuid}/cancel-shipment/     Note over M,API: Header: X-API-KEY (بدون بدنه)      alt روش ارسال DigiExpress نیست         API--&gt;&gt;M: 400 خطا         Note over API,M: {error: \&quot;Selected shipping method is not DigiExpress\&quot;}     else مرسوله قابل لغو نیست         API--&gt;&gt;M: 400 خطا         Note over API,M: {error: \&quot;...\&quot;}     else لغو موفق         API-&gt;&gt;DX: لغو مرسوله         DX--&gt;&gt;API: تأیید لغو         API--&gt;&gt;M: 200 موفق         Note over API,M: {message, order_uuid, status, status_display}     end &#x60;&#x60;&#x60; 
  # @param order_uuid 
  # @param [Hash] opts the optional parameters
  # @return [MerchantOrderCancelShipmentResponse]
  describe 'order_api_v1_manager_cancel_shipment_create test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_change_shipping_method_update
  # تغییر روش ارسال
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  تغییر روش ارسال سفارش  ## توضیحات  این endpoint به فروشنده اجازه می‌دهد روش ارسال یک سفارش را تغییر دهد. این عملیات معمولاً زمانی استفاده می‌شود که فروشنده بخواهد از DigiExpress به روش ارسال پیش‌فرض (یا بالعکس) تغییر دهد.  نیاز به **API_KEY** فروشنده دارد.  ## پارامترهای ورودی  * **updated_shipping**: شناسه روش ارسال جدید * **preparation_time** (اختیاری): زمان آماده‌سازی (روز) برای DigiExpress  &lt;/div&gt; 
  # @param order_uuid 
  # @param order_detail 
  # @param [Hash] opts the optional parameters
  # @return [OrderDetail]
  describe 'order_api_v1_manager_change_shipping_method_update test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_list
  # لیست سفارشات
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  لیست سفارشات فروشنده  ## توضیحات  این endpoint لیست تمام سفارشات مرتبط با فروشنده را با امکان فیلتر، جستجو و مرتب‌سازی برمی‌گرداند. نتایج به صورت صفحه‌بندی‌شده (Cursor Pagination) ارسال می‌شوند و به ترتیب جدیدترین سفارش اول مرتب می‌شوند.  نیاز به **API_KEY** فروشنده دارد.  ## پارامترهای فیلتر  * **status**: وضعیت سفارش (INITIAL, PENDING, PAID_BY_USER, VERIFIED_BY_MERCHANT, ...) * **created_at__gte / created_at__lte**: فیلتر بر اساس تاریخ ایجاد * **search**: جستجو در شماره تلفن مشتری، نام، کد مرجع، شناسه سفارش مرچنت * **ordering**: مرتب‌سازی بر اساس created_at, final_amount, status, merchant_order_id  &lt;/div&gt; 
  # @param [Hash] opts the optional parameters
  # @option opts [String] :cities 
  # @option opts [Date] :created_at 
  # @option opts [String] :cursor مقدار نشانگر صفحه‌بندی.
  # @option opts [String] :order_ids 
  # @option opts [String] :ordering کدام فیلد باید هنگام مرتب‌سازی نتایج استفاده شود.
  # @option opts [String] :payment_types 
  # @option opts [String] :provinces 
  # @option opts [String] :reference_code 
  # @option opts [String] :search یک عبارت جستجو.
  # @option opts [String] :shipping_types 
  # @option opts [Integer] :status * &#x60;1&#x60; - اولیه * &#x60;2&#x60; - شروع در * &#x60;3&#x60; - در انتظار * &#x60;4&#x60; - در انتظار درگاه * &#x60;5&#x60; - منقضی شده * &#x60;6&#x60; - لغو شده * &#x60;7&#x60; - ممنوع شده توسط ما * &#x60;8&#x60; - ناموفق در پرداخت * &#x60;9&#x60; - تأیید شده توسط فروشنده * &#x60;10&#x60; - ناموفق در تأیید توسط فروشنده * &#x60;11&#x60; - فروشگاه * &#x60;12&#x60; - لغو شده توسط فروشنده * &#x60;13&#x60; - درخواست بازگرداندن وجه به مشتری به دلیل درخواست مشتری * &#x60;14&#x60; - درخواست بازگرداندن وجه به فروشنده پس از ناموفقی در تأیید توسط فروشنده * &#x60;15&#x60; - درخواست بازگرداندن وجه به مشتری پس از ناموفقی توسط فروشنده * &#x60;16&#x60; - بازگردانده شده به فروشنده پس از لغو توسط فروشنده * &#x60;17&#x60; - بازگرداندن وجه تکمیل شد * &#x60;18&#x60; - زمان مجاز برای منقضی کردن گذشته است * &#x60;19&#x60; - تحویل نشده * &#x60;20&#x60; - مرسوله
  # @option opts [String] :statuses 
  # @option opts [Boolean] :today_pickup 
  # @return [PaginatedOrderDetailList]
  describe 'order_api_v1_manager_list test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_paid_list
  # سفارش پرداخت‌شده و تایید‌نشده
  # لیست تمامی سفارشاتی که توسط کاربر پرداخت شده اند ولی توسط فروشنده تایید نشده اند. 
  # @param [Hash] opts the optional parameters
  # @option opts [String] :cities 
  # @option opts [Date] :created_at 
  # @option opts [String] :cursor مقدار نشانگر صفحه‌بندی.
  # @option opts [String] :order_ids 
  # @option opts [String] :ordering کدام فیلد باید هنگام مرتب‌سازی نتایج استفاده شود.
  # @option opts [String] :payment_types 
  # @option opts [String] :provinces 
  # @option opts [String] :reference_code 
  # @option opts [String] :search یک عبارت جستجو.
  # @option opts [String] :shipping_types 
  # @option opts [Integer] :status * &#x60;1&#x60; - اولیه * &#x60;2&#x60; - شروع در * &#x60;3&#x60; - در انتظار * &#x60;4&#x60; - در انتظار درگاه * &#x60;5&#x60; - منقضی شده * &#x60;6&#x60; - لغو شده * &#x60;7&#x60; - ممنوع شده توسط ما * &#x60;8&#x60; - ناموفق در پرداخت * &#x60;9&#x60; - تأیید شده توسط فروشنده * &#x60;10&#x60; - ناموفق در تأیید توسط فروشنده * &#x60;11&#x60; - فروشگاه * &#x60;12&#x60; - لغو شده توسط فروشنده * &#x60;13&#x60; - درخواست بازگرداندن وجه به مشتری به دلیل درخواست مشتری * &#x60;14&#x60; - درخواست بازگرداندن وجه به فروشنده پس از ناموفقی در تأیید توسط فروشنده * &#x60;15&#x60; - درخواست بازگرداندن وجه به مشتری پس از ناموفقی توسط فروشنده * &#x60;16&#x60; - بازگردانده شده به فروشنده پس از لغو توسط فروشنده * &#x60;17&#x60; - بازگرداندن وجه تکمیل شد * &#x60;18&#x60; - زمان مجاز برای منقضی کردن گذشته است * &#x60;19&#x60; - تحویل نشده * &#x60;20&#x60; - مرسوله
  # @option opts [String] :statuses 
  # @option opts [Boolean] :today_pickup 
  # @return [PaginatedMerchantPaidOrderListList]
  describe 'order_api_v1_manager_paid_list test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_refund_create
  # بازگشت سفارش
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt; بازگشت و لغو سفارش  ## توضیحات  این endpoint برای بازگشت یا لغو سفارشی استفاده می‌شود که قبلاً پرداخت شده یا تایید شده است. در این مرحله مبلغ سفارش به کاربر بازگشت داده می‌شود و وضعیت سفارش به **REFUNDED** تغییر می‌یابد.   ## شرایط بازگشت  سفارش باید در یکی از وضعیت‌های زیر باشد تا بازگشت امکان‌پذیر باشد: * **PAID_BY_USER**: سفارش پرداخت شده است اما هنوز تایید نشده * **VERIFIED_BY_MERCHANT**: سفارش تایید شده است  سفارش نباید قبلاً بازگشت داده شده باشد.  **پاسخ خطا** - اگر سفارش در وضعیت مناسب نباشد یا قبلاً بازگشت داده شده باشد &lt;/div&gt;  &#x60;&#x60;&#x60;mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API      M-&gt;&gt;API: POST /api/v1/orders/manager/{uuid}/refund     Note over M,API: {reason: \&quot;درخواست مشتری\&quot;}      alt سفارش قابل بازگشت نیست         API--&gt;&gt;M: 500 خطا         Note over API,M: {error: \&quot;شروع بازگشت ناموفق بود.&lt;br/&gt;لطفاً دوباره تلاش کنید.\&quot;}     else سفارش معتبر است         API--&gt;&gt;M: 200 موفق         Note over API,M: {message: \&quot;درخواست بازگشت با&lt;br/&gt;موفقیت شروع شد\&quot;,&lt;br/&gt;order_uuid, status: 13,&lt;br/&gt;status_display,&lt;br/&gt;refund_reason}          M-&gt;&gt;API: GET /api/v1/orders/manager/{uuid}         Note over M,API: بررسی وضعیت سفارش&lt;br/&gt;(endpoint جداگانه /refund/status وجود ندارد)          alt status: 17 (بازگشت تکمیل شد)             API--&gt;&gt;M: 200 موفق             Note over API,M: {order_uuid, status: 17,&lt;br/&gt;status_display: \&quot;بازگشت تکمیل شد\&quot;,&lt;br/&gt;metadata.refund_tracking_code,&lt;br/&gt;metadata.refund_completed_at}          else status: 13 (در حال پردازش)             API--&gt;&gt;M: 200 موفق             Note over API,M: {order_uuid, status: 13,&lt;br/&gt;status_display: \&quot;درخواست بازگشت به مشتری&lt;br/&gt;به دلیل درخواست&lt;br/&gt;مشتری\&quot;,&lt;br/&gt;metadata.refund_reason}          else status: قبلی (بازگشت ناموفق)             API--&gt;&gt;M: 200 موفق             Note over API,M: {order_uuid, status: (قبلی),&lt;br/&gt;metadata.refund_error,&lt;br/&gt;metadata.refund_failed_at}         end     end &#x60;&#x60;&#x60; 
  # @param order_uuid 
  # @param [Hash] opts the optional parameters
  # @option opts [RefundOrder] :refund_order 
  # @return [MerchantOrderRefundResponse]
  describe 'order_api_v1_manager_refund_create test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_retrieve
  # دریافت سفارش
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  # مدیریت سفارشات  ## توضیحات  این endpoint برای مدیریت و مشاهده سفارشات فروشنده استفاده می‌شود.  &lt;/div&gt; 
  # @param order_uuid 
  # @param [Hash] opts the optional parameters
  # @return [OrderDetail]
  describe 'order_api_v1_manager_retrieve test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_revive_shipment_create
  # احیای ارسال سفارش
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  احیای مرسوله دیجی‌اکسپرس  ## توضیحات  این endpoint برای احیای (reactivate) یک مرسوله دیجی‌اکسپرس که قبلاً لغو شده یا در وضعیت غیرفعال است استفاده می‌شود. با ارسال &#x60;preparation_time&#x60; (زمان آماده‌سازی بر حسب روز)، زمان جدید آماده بودن بار تنظیم می‌شود.  نیاز به **API_KEY** فروشنده دارد.  ## پارامترهای ورودی  * **preparation_time** (اختیاری، پیش‌فرض: ۲): تعداد روز تا آماده‌شدن بار برای تحویل به پیک  ## شرایط  * سفارش باید دارای روش ارسال **DigiExpress** باشد * مرسوله باید در وضعیت قابل احیا باشد  &lt;/div&gt;  &#x60;&#x60;&#x60;mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API     participant DX as دیجی‌اکسپرس      M-&gt;&gt;API: POST /order/api/v1/manager/{order_uuid}/revive-shipment/     Note over M,API: Header: X-API-KEY&lt;br/&gt;{preparation_time: 2}      alt روش ارسال DigiExpress نیست         API--&gt;&gt;M: 400 خطا         Note over API,M: {error: \&quot;Selected shipping method is not DigiExpress\&quot;}     else احیا موفق         API-&gt;&gt;DX: احیای مرسوله با زمان جدید         DX--&gt;&gt;API: تأیید احیا         API--&gt;&gt;M: 200 موفق         Note over API,M: {message, order_uuid, status, status_display}     end &#x60;&#x60;&#x60; 
  # @param order_uuid 
  # @param [Hash] opts the optional parameters
  # @option opts [ReviveShipment] :revive_shipment 
  # @return [MerchantOrderReviveShipmentResponse]
  describe 'order_api_v1_manager_revive_shipment_create test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_update_status_update
  # به‌روزرسانی وضعیت سفارش
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  بروزرسانی وضعیت سفارش  ## توضیحات  این endpoint به فروشنده امکان می‌دهد وضعیت یک سفارش را به‌صورت مستقیم تغییر دهد. این endpoint برای مواردی مانند علامت‌گذاری سفارش به‌عنوان «ارسال شده» یا «تحویل داده شده» توسط فروشنده استفاده می‌شود.  نیاز به **API_KEY** فروشنده دارد.  ## وضعیت‌های مجاز  * **DELIVERED**: تحویل شد * **DISPATCHED**: ارسال شد * سایر وضعیت‌های تعریف‌شده در سیستم  &lt;/div&gt;  &#x60;&#x60;&#x60;mermaid sequenceDiagram     participant M as فروشنده     participant API as BWDK API      M-&gt;&gt;API: PUT /order/api/v1/manager/{order_uuid}/update-status/     Note over M,API: Header: X-API-KEY&lt;br/&gt;{status: \&quot;DELIVERED\&quot;}      alt وضعیت معتبر است         API--&gt;&gt;M: 200 موفق         Note over API,M: اطلاعات کامل سفارش با وضعیت جدید     else وضعیت نامعتبر است         API--&gt;&gt;M: 400 خطا         Note over API,M: {error: \&quot;invalid status\&quot;}     end &#x60;&#x60;&#x60; 
  # @param order_uuid 
  # @param update_order_status 
  # @param [Hash] opts the optional parameters
  # @return [OrderDetail]
  describe 'order_api_v1_manager_update_status_update test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for order_api_v1_manager_verify_create
  # تایید سفارش
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  تایید سفارش پس از پرداخت  ## توضیحات  پس از اتمام فرایند پرداخت توسط کاربر، مرچنت باید سفارش را تایید کند. این endpoint برای تایید و نهایی کردن سفارش پس از پرداخت موفق توسط مشتری استفاده می‌شود. در این مرحله مرچنت سفارش را تایید می‌کند و وضعیت سفارش به **VERIFIED_BY_MERCHANT** تغییر می‌یابد.  ## روند کاری  **مرحله ۲: بازگشت کاربر و دریافت نتیجه**  پس از تکمیل فرایند پرداخت (موفق یا ناموفق)، کاربر به آدرس callback_url که هنگام ساخت سفارش ارسال کرده بودید بازگردانده می‌شود. در این درخواست وضعیت سفارش به صورت query parameters ارسال می‌شود:   **Query Parameters:** * **success**: متغیر منطقی نشان‌دهنده موفق یا ناموفق بودن سفارش * **status**: وضعیت سفارش (PAID، FAILED، وغیره) * **phone_number**: شماره تلفن مشتری * **order_uuid**: شناسه یکتای سفارش * **merchant_order_id**: شناسه سفارش در سیستم مرچنت  **مرحله ۳: تایید سفارش در بک‌اند**  سپس شما باید این endpoint را فراخوانی کنید تا سفارش را تایید کنید و اطمینان حاصل کنید که سفارش موفقیت‌آمیز ثبت شده است: &lt;/div&gt; 
  # @param order_uuid 
  # @param verify_order 
  # @param [Hash] opts the optional parameters
  # @return [OrderDetail]
  describe 'order_api_v1_manager_verify_create test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

  # unit tests for wallets_api_v1_wallet_balance_retrieve
  # دریافت موجودی کیف پول
  # &lt;div dir&#x3D;\&quot;rtl\&quot; style&#x3D;\&quot;text-align: right;\&quot;&gt;  موجودی کیف پول فروشنده  ## توضیحات  این endpoint موجودی کیف پول فروشنده را برمی‌گرداند. کیف پول برای پرداخت هزینه ارسال دیجی‌اکسپرس استفاده می‌شود. هنگام ثبت مرسوله دیجی‌اکسپرس، هزینه ارسال به‌صورت خودکار از کیف پول کسر می‌شود.  نیاز به **API_KEY** فروشنده دارد.  &lt;/div&gt; 
  # @param [Hash] opts the optional parameters
  # @return [WalletBalance]
  describe 'wallets_api_v1_wallet_balance_retrieve test' do
    it 'should work' do
      # assertion here. ref: https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/
    end
  end

end
