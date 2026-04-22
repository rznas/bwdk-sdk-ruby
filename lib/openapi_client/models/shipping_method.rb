=begin
#BWDK API

#<div dir=\"rtl\" style=\"text-align: right;\">  # مستندات فروشندگان در سرویس خرید با دیجی‌کالا  این پلتفرم برای فروشندگان (مرچنت‌ها) جهت یکپارچه‌سازی خدمات پرداخت و تجارت الکترونیکی با سیستم خرید با دیجی‌کالا. شامل مدیریت سفارشات، ارسال، و احراز هویت فروشندگان است.     ```mermaid flowchart TD     START([شروع]) --> INITIAL      INITIAL[\"1️⃣ INITIAL\\nسفارش ایجاد شد\"]     STARTED[\"2️⃣ STARTED\\nمشتری به BWDK هدایت شد\"]     PENDING[\"3️⃣ PENDING\\nمشتری وارد شد و سفارش در انتظار پرداخت\"]     WAITING_FOR_GATEWAY[\"4️⃣ WAITING_FOR_GATEWAY\\nمشتری به درگاه پرداخت هدایت شد\"]     PAID_BY_USER[\"7️⃣ PAID_BY_USER\\nپرداخت موفق\"]     VERIFIED_BY_MERCHANT[\"9️⃣ VERIFIED_BY_MERCHANT\\nتأیید شده توسط فروشنده\"]     SHIPPED[\"🚚 SHIPPED\\nارسال شد\"]     DELIVERED[\"✅ DELIVERED\\nتحویل داده شد\"]      EXPIRED[\"⏰ EXPIRED\\nمنقضی شد\"]     EXPIRATION_TIME_EXCEEDED[\"⏱️ EXPIRATION_TIME_EXCEEDED\\nزمان انقضا گذشت\"]     CANCELLED[\"❌ CANCELLED\\nلغو توسط مشتری\"]     FAILED_TO_PAY[\"💳 FAILED_TO_PAY\\nپرداخت ناموفق\"]     FAILED_TO_VERIFY_BY_MERCHANT[\"🔴 FAILED_TO_VERIFY_BY_MERCHANT\\nتأیید مرچنت ناموفق\"]     FAILED_BY_MERCHANT[\"🔴 FAILED_BY_MERCHANT\\nخطا از سمت مرچنت\"]     CANCELLED_BY_MERCHANT[\"🔴 CANCELLED_BY_MERCHANT\\nلغو توسط مرچنت\"]      R_CUSTOMER_REQUEST[\"1️⃣3️⃣ REQUEST_TO_REFUND\\nدرخواست استرداد توسط مشتری\"]     R_FAILED_VERIFY[\"1️⃣4️⃣ REQUEST_TO_REFUND\\nاسترداد پس از تأیید ناموفق مرچنت\"]     R_FAILED_MERCHANT[\"1️⃣5️⃣ REQUEST_TO_REFUND\\nاسترداد پس از خطای مرچنت\"]     R_CANCELLED_MERCHANT[\"1️⃣6️⃣ REQUEST_TO_REFUND\\nاسترداد پس از لغو مرچنت\"]     REFUND_COMPLETED[\"✅ REFUND_COMPLETED\\nاسترداد تکمیل شد\"]      INITIAL -->|\"مرچنت سفارش ایجاد کرد\"| STARTED     STARTED -->|\"مشتری وارد سیستم شد\"| PENDING     PENDING -->|\"مشتری سفارش را نهایی و ثبت کرد\"| WAITING_FOR_GATEWAY     WAITING_FOR_GATEWAY -->|\"پرداخت با موفقیت انجام شد\"| PAID_BY_USER     PAID_BY_USER -->|\"مرچنت سفارش را تأیید کرد\"| VERIFIED_BY_MERCHANT     VERIFIED_BY_MERCHANT -->|\"مرچنت وضعیت را به ارسال تغییر داد\"| SHIPPED     SHIPPED -->|\"مرچنت تحویل را تأیید کرد\"| DELIVERED      INITIAL -->|\"زمان رزرو به پایان رسید\"| EXPIRED     STARTED -->|\"زمان رزرو به پایان رسید\"| EXPIRED     PENDING -->|\"زمان رزرو به پایان رسید\"| EXPIRED     WAITING_FOR_GATEWAY -->|\"زمان رزرو به پایان رسید\"| EXPIRED      PENDING -->|\"زمان مجاز سفارش سپری شده بود\"| EXPIRATION_TIME_EXCEEDED     WAITING_FOR_GATEWAY -->|\"زمان مجاز سفارش سپری شده بود\"| EXPIRATION_TIME_EXCEEDED      PENDING -->|\"مشتری انصراف داد\"| CANCELLED     WAITING_FOR_GATEWAY -->|\"مشتری انصراف داد\"| CANCELLED      WAITING_FOR_GATEWAY -->|\"پرداخت ناموفق بود\"| FAILED_TO_PAY      PAID_BY_USER -->|\"مرچنت تأیید را رد کرد\"| FAILED_TO_VERIFY_BY_MERCHANT     PAID_BY_USER -->|\"مرچنت اعلام ناتوانی در انجام سفارش کرد\"| FAILED_BY_MERCHANT     PAID_BY_USER -->|\"مرچنت سفارش را لغو کرد\"| CANCELLED_BY_MERCHANT     VERIFIED_BY_MERCHANT -->|\"مرچنت سفارش را لغو کرد\"| CANCELLED_BY_MERCHANT      PAID_BY_USER -->|\"مرچنت درخواست استرداد داد\"| R_CUSTOMER_REQUEST     VERIFIED_BY_MERCHANT -->|\"مرچنت درخواست استرداد داد\"| R_CUSTOMER_REQUEST     FAILED_TO_VERIFY_BY_MERCHANT -->|\"سیستم استرداد را آغاز کرد\"| R_FAILED_VERIFY     FAILED_BY_MERCHANT -->|\"سیستم استرداد را آغاز کرد\"| R_FAILED_MERCHANT     CANCELLED_BY_MERCHANT -->|\"سیستم استرداد را آغاز کرد\"| R_CANCELLED_MERCHANT      R_CUSTOMER_REQUEST -->|\"استرداد توسط دیجی‌پی تأیید شد\"| REFUND_COMPLETED     R_FAILED_VERIFY -->|\"استرداد توسط دیجی‌پی تأیید شد\"| REFUND_COMPLETED     R_FAILED_MERCHANT -->|\"استرداد توسط دیجی‌پی تأیید شد\"| REFUND_COMPLETED     R_CANCELLED_MERCHANT -->|\"استرداد توسط دیجی‌پی تأیید شد\"| REFUND_COMPLETED      style INITIAL fill:#9e9e9e,color:#fff     style STARTED fill:#1565c0,color:#fff     style PENDING fill:#ef6c00,color:#fff     style WAITING_FOR_GATEWAY fill:#6a1b9a,color:#fff     style PAID_BY_USER fill:#2e7d32,color:#fff     style VERIFIED_BY_MERCHANT fill:#1b5e20,color:#fff     style SHIPPED fill:#0277bd,color:#fff     style DELIVERED fill:#1b5e20,color:#fff     style EXPIRED fill:#b71c1c,color:#fff     style EXPIRATION_TIME_EXCEEDED fill:#b71c1c,color:#fff     style CANCELLED fill:#7f0000,color:#fff     style FAILED_TO_PAY fill:#b71c1c,color:#fff     style FAILED_TO_VERIFY_BY_MERCHANT fill:#b71c1c,color:#fff     style FAILED_BY_MERCHANT fill:#b71c1c,color:#fff     style CANCELLED_BY_MERCHANT fill:#7f0000,color:#fff     style R_CUSTOMER_REQUEST fill:#e65100,color:#fff     style R_FAILED_VERIFY fill:#e65100,color:#fff     style R_FAILED_MERCHANT fill:#e65100,color:#fff     style R_CANCELLED_MERCHANT fill:#e65100,color:#fff     style REFUND_COMPLETED fill:#2e7d32,color:#fff ```  ---  <div dir=\"rtl\" style=\"text-align: right;\">  ## توضیح وضعیت‌های سفارش  ### ۱. INITIAL — ایجاد اولیه سفارش  **معنا:** سفارش توسط بک‌اند مرچنت ساخته شده ولی هنوز هیچ کاربری به آن اختصاص داده نشده است.  **چگونه اتفاق می‌افتد:** مرچنت با ارسال درخواست `POST /api/v1/orders/create` و ارائه اطلاعات کالاها، مبلغ و `callback_url`، یک سفارش جدید ایجاد می‌کند. BWDK یک `order_uuid` منحصربه‌فرد و لینک شروع سفارش (`order_start_url`) برمی‌گرداند.  **وابستگی‌ها:** نیازی به کاربر یا پرداخت ندارد. فقط اطلاعات کالا از سمت مرچنت کافی است.  ---  ### ۲. STARTED — آغاز جریان خرید  **معنا:** مشتری روی لینک شروع سفارش کلیک کرده و وارد محیط BWDK شده است، اما هنوز لاگین نکرده.  **چگونه اتفاق می‌افتد:** وقتی مشتری به `order_start_url` هدایت می‌شود، BWDK وضعیت سفارش را از `INITIAL` به `STARTED` تغییر می‌دهد. در این مرحله فرآیند احراز هویت (SSO) آغاز می‌شود.  **وابستگی‌ها:** مشتری باید به لینک شروع هدایت شده باشد.  ---  ### ۳. PENDING — انتظار برای تکمیل سفارش  **معنا:** مشتری با موفقیت وارد سیستم شده و سفارش به حساب او اختصاص یافته. مشتری در حال انتخاب آدرس، روش ارسال، بسته‌بندی یا تخفیف است.  **چگونه اتفاق می‌افتد:** پس از تکمیل ورود به سیستم (SSO)، BWDK سفارش را به کاربر وصل کرده و وضعیت را به `PENDING` تغییر می‌دهد.  **وابستگی‌ها:** ورود موفق کاربر به سیستم (SSO). در این مرحله مشتری می‌تواند آدرس، شیپینگ، پکینگ و تخفیف را انتخاب کند.  ---  ### ۴. WAITING_FOR_GATEWAY — انتظار برای پرداخت  **معنا:** مشتری اطلاعات سفارش را تأیید کرده و به درگاه پرداخت هدایت شده است.  **چگونه اتفاق می‌افتد:** مشتری دکمه «پرداخت» را می‌زند (`POST /api/v1/orders/submit`)، سیستم یک رکورد پرداخت ایجاد می‌کند و کاربر به درگاه Digipay هدایت می‌شود. وضعیت سفارش به `WAITING_FOR_GATEWAY` تغییر می‌کند.  **وابستگی‌ها:** انتخاب آدرس، روش ارسال و بسته‌بندی الزامی است. پرداخت باید ایجاد شده باشد.  ---  ### ۷. PAID_BY_USER — پرداخت موفق  **معنا:** تراکنش پرداخت با موفقیت انجام شده و وجه از حساب مشتری کسر شده است.  **چگونه اتفاق می‌افتد:** درگاه پرداخت نتیجه موفق را به BWDK اطلاع می‌دهد. سیستم پرداخت را تأیید و وضعیت سفارش را به `PAID_BY_USER` تغییر می‌دهد. در این لحظه مشتری به `callback_url` مرچنت هدایت می‌شود.  **وابستگی‌ها:** تأیید موفق تراکنش از سوی درگاه پرداخت (Digipay).  ---  ### ۹. VERIFIED_BY_MERCHANT — تأیید توسط مرچنت  **معنا:** مرچنت سفارش را بررسی کرده و موجودی کالا و صحت اطلاعات را تأیید نموده است. سفارش آماده ارسال است.  **چگونه اتفاق می‌افتد:** مرچنت با ارسال درخواست `POST /api/v1/orders/manager/{uuid}/verify` سفارش را تأیید می‌کند. این مرحله **اجباری** است و باید پس از پرداخت موفق انجام شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد. مرچنت باید موجودی کالا را بررسی کند.  ---  ### ۲۰. SHIPPED — ارسال شد  **معنا:** سفارش از انبار خارج شده و در حال ارسال به مشتری است.  **چگونه اتفاق می‌افتد:** مرچنت پس از ارسال کالا، وضعیت سفارش را از طریق API به `SHIPPED` تغییر می‌دهد.  **وابستگی‌ها:** سفارش باید در وضعیت `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۹. DELIVERED — تحویل داده شد  **معنا:** سفارش به دست مشتری رسیده و فرآیند خرید به پایان رسیده است.  **چگونه اتفاق می‌افتد:** مرچنت پس از تحویل موفق، وضعیت را به `DELIVERED` تغییر می‌دهد.  **وابستگی‌ها:** سفارش باید در وضعیت `SHIPPED` باشد.  ---  ### ۵. EXPIRED — منقضی شد  **معنا:** زمان رزرو سفارش به پایان رسیده و سفارش به صورت خودکار لغو شده است.  **چگونه اتفاق می‌افتد:** یک Task دوره‌ای به طور خودکار سفارش‌هایی که `reservation_expired_at` آن‌ها گذشته را پیدا کرده و وضعیتشان را به `EXPIRED` تغییر می‌دهد. این مکانیزم مانع بلوکه شدن موجودی کالا می‌شود.  **وابستگی‌ها:** سفارش باید در یکی از وضعیت‌های `INITIAL`، `STARTED`، `PENDING` یا `WAITING_FOR_GATEWAY` باشد و زمان رزرو آن گذشته باشد.  ---  ### ۱۸. EXPIRATION_TIME_EXCEEDED — زمان انقضا گذشت  **معنا:** در لحظه ثبت نهایی یا پرداخت، مشخص شد که زمان مجاز سفارش تمام شده است.  **چگونه اتفاق می‌افتد:** هنگام ارسال درخواست پرداخت (`submit_order`)، سیستم بررسی می‌کند که `expiration_time` سفارش هنوز معتبر است یا خیر. در صورت گذشتن زمان، وضعیت به `EXPIRATION_TIME_EXCEEDED` تغییر می‌کند.  **وابستگی‌ها:** سفارش در وضعیت `PENDING` یا `WAITING_FOR_GATEWAY` است و فیلد `expiration_time` سپری شده.  ---  ### ۶. CANCELLED — لغو توسط مشتری  **معنا:** مشتری در حین فرآیند خرید (قبل از پرداخت) سفارش را لغو کرده یا از صفحه خارج شده است.  **چگونه اتفاق می‌افتد:** مشتری در صفحه checkout دکمه «انصراف» را می‌زند یا پرداخت ناموفق بوده و سفارش به حالت لغو درمی‌آید.  **وابستگی‌ها:** سفارش باید در وضعیت `PENDING` یا `WAITING_FOR_GATEWAY` باشد. پرداختی انجام نشده است.  ---  ### ۸. FAILED_TO_PAY — پرداخت ناموفق  **معنا:** تراکنش پرداخت انجام نشد یا با خطا مواجه شد.  **چگونه اتفاق می‌افتد:** درگاه پرداخت نتیجه ناموفق برمی‌گرداند یا فرآیند بازگشت وجه در مرحله پرداخت با شکست مواجه می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `WAITING_FOR_GATEWAY` بوده باشد.  ---  ### ۱۰. FAILED_TO_VERIFY_BY_MERCHANT — تأیید ناموفق توسط مرچنت  **معنا:** مرچنت سفارش را رد کرده است؛ معمولاً به دلیل ناموجود بودن کالا یا مغایرت اطلاعات.  **چگونه اتفاق می‌افتد:** مرچنت در پاسخ به درخواست verify، خطا برمی‌گرداند یا API آن وضعیت ناموفق تنظیم می‌کند. پس از این وضعیت، فرآیند استرداد وجه آغاز می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد.  ---  ### ۱۱. FAILED_BY_MERCHANT — خطا از سمت مرچنت  **معنا:** مرچنت پس از تأیید اولیه، اعلام می‌کند که قادر به انجام سفارش نیست (مثلاً به دلیل اتمام موجودی).  **چگونه اتفاق می‌افتد:** مرچنت وضعیت را به `FAILED_BY_MERCHANT` تغییر می‌دهد. وجه پرداختی مشتری مسترد خواهد شد.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد.  ---  ### ۱۲. CANCELLED_BY_MERCHANT — لغو توسط مرچنت  **معنا:** مرچنت پس از پرداخت، سفارش را به هر دلیلی لغو کرده است.  **چگونه اتفاق می‌افتد:** مرچنت درخواست لغو سفارش را ارسال می‌کند. وجه پرداختی مشتری به او بازگردانده می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` یا `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۳. REQUEST_TO_REFUND — درخواست استرداد توسط مشتری  **معنا:** مشتری درخواست بازگشت وجه داده و سیستم در حال پردازش استرداد است.  **چگونه اتفاق می‌افتد:** مرچنت از طریق API درخواست استرداد را ثبت می‌کند (`POST /api/v1/orders/manager/{uuid}/refund`). سفارش وارد صف پردازش استرداد می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` یا `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۴، ۱۵، ۱۶. سایر وضعیت‌های درخواست استرداد  این وضعیت‌ها بر اساس دلیل استرداد از هم تفکیک می‌شوند:  - **۱۴ — REQUEST_TO_REFUND_TO_MERCHANT_AFTER_FAILED_TO_VERIFY:** استرداد پس از ناموفق بودن تأیید مرچنت؛ وجه به حساب مرچنت بازمی‌گردد. - **۱۵ — REQUEST_TO_REFUND_TO_CUSTOMER_AFTER_FAILED_BY_MERCHANT:** استرداد پس از خطای مرچنت؛ وجه به مشتری بازمی‌گردد. - **۱۶ — REQUEST_TO_REFUND_TO_MERCHANT_AFTER_CANCELLED_BY_MERCHANT:** استرداد پس از لغو توسط مرچنت؛ وجه به حساب مرچنت برمی‌گردد.  **چگونه اتفاق می‌افتد:** به صورت خودکار پس از رسیدن به وضعیت‌های ناموفق/لغو مربوطه توسط سیستم تنظیم می‌شود.  ---  ### ۱۷. REFUND_COMPLETED — استرداد تکمیل شد  **معنا:** وجه با موفقیت به صاحب آن (مشتری یا مرچنت بسته به نوع استرداد) بازگردانده شده است.  **چگونه اتفاق می‌افتد:** Task پردازش استرداد (`process_order_refund`) پس از تأیید موفق بازگشت وجه از سوی Digipay، وضعیت سفارش را به `REFUND_COMPLETED` تغییر می‌دهد.  **وابستگی‌ها:** یکی از وضعیت‌های درخواست استرداد (۱۳، ۱۴، ۱۵ یا ۱۶) باید فعال باشد و Digipay تراکنش استرداد را تأیید کرده باشد.  </div> 

The version of the OpenAPI document: 1.0.0

Generated by: https://openapi-generator.tech
Generator version: 7.21.0

=end

require 'date'
require 'time'

module OpenapiClient
  # Serializer for shipping method details.
  class ShippingMethod < ApiModelBase
    attr_accessor :id

    # نام روش/گزینه بسته‌بندی
    attr_accessor :name

    # شناسه روش ارسال برای استفاده در سفارش
    attr_accessor :description

    # شناسه وضعیت ارسال از دیجی اکسپرس  * `1` - سایر * `2` - دیجی اکسپرس
    attr_accessor :shipping_type

    attr_accessor :get_shipping_type_display

    attr_accessor :shipping_type_display

    # هزینه ارسال برای منطقه اصلی (مثلاً تهران) به تومان
    attr_accessor :cost

    # هزینه ارسال برای مناطق دیگر به تومان
    attr_accessor :secondary_cost

    # حداقل تعداد روز از تاریخ سفارش تا تحویل
    attr_accessor :minimum_time_sending

    # Maximum number of days from order date to delivery
    attr_accessor :maximum_time_sending

    attr_accessor :delivery_time_display

    attr_accessor :delivery_time_range_display

    attr_accessor :inventory_address

    # آیا روش ارسال پرداخت در مقصد است
    attr_accessor :is_pay_at_destination

    class EnumAttributeValidator
      attr_reader :datatype
      attr_reader :allowable_values

      def initialize(datatype, allowable_values)
        @allowable_values = allowable_values.map do |value|
          case datatype.to_s
          when /Integer/i
            value.to_i
          when /Float/i
            value.to_f
          else
            value
          end
        end
      end

      def valid?(value)
        !value || allowable_values.include?(value)
      end
    end

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'name' => :'name',
        :'description' => :'description',
        :'shipping_type' => :'shipping_type',
        :'get_shipping_type_display' => :'get_shipping_type_display',
        :'shipping_type_display' => :'shipping_type_display',
        :'cost' => :'cost',
        :'secondary_cost' => :'secondary_cost',
        :'minimum_time_sending' => :'minimum_time_sending',
        :'maximum_time_sending' => :'maximum_time_sending',
        :'delivery_time_display' => :'delivery_time_display',
        :'delivery_time_range_display' => :'delivery_time_range_display',
        :'inventory_address' => :'inventory_address',
        :'is_pay_at_destination' => :'is_pay_at_destination'
      }
    end

    # Returns attribute mapping this model knows about
    def self.acceptable_attribute_map
      attribute_map
    end

    # Returns all the JSON keys this model knows about
    def self.acceptable_attributes
      acceptable_attribute_map.values
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'id' => :'Integer',
        :'name' => :'String',
        :'description' => :'String',
        :'shipping_type' => :'ShippingTypeEnum',
        :'get_shipping_type_display' => :'String',
        :'shipping_type_display' => :'String',
        :'cost' => :'Integer',
        :'secondary_cost' => :'Integer',
        :'minimum_time_sending' => :'Integer',
        :'maximum_time_sending' => :'Integer',
        :'delivery_time_display' => :'String',
        :'delivery_time_range_display' => :'DeliveryTimeRangeDisplay',
        :'inventory_address' => :'BusinessAddress',
        :'is_pay_at_destination' => :'Boolean'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
      ])
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `OpenapiClient::ShippingMethod` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      acceptable_attribute_map = self.class.acceptable_attribute_map
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!acceptable_attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `OpenapiClient::ShippingMethod`. Please check the name to make sure it's valid. List of attributes: " + acceptable_attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'id')
        self.id = attributes[:'id']
      else
        self.id = nil
      end

      if attributes.key?(:'name')
        self.name = attributes[:'name']
      else
        self.name = nil
      end

      if attributes.key?(:'description')
        self.description = attributes[:'description']
      end

      if attributes.key?(:'shipping_type')
        self.shipping_type = attributes[:'shipping_type']
      end

      if attributes.key?(:'get_shipping_type_display')
        self.get_shipping_type_display = attributes[:'get_shipping_type_display']
      else
        self.get_shipping_type_display = nil
      end

      if attributes.key?(:'shipping_type_display')
        self.shipping_type_display = attributes[:'shipping_type_display']
      else
        self.shipping_type_display = nil
      end

      if attributes.key?(:'cost')
        self.cost = attributes[:'cost']
      end

      if attributes.key?(:'secondary_cost')
        self.secondary_cost = attributes[:'secondary_cost']
      end

      if attributes.key?(:'minimum_time_sending')
        self.minimum_time_sending = attributes[:'minimum_time_sending']
      end

      if attributes.key?(:'maximum_time_sending')
        self.maximum_time_sending = attributes[:'maximum_time_sending']
      end

      if attributes.key?(:'delivery_time_display')
        self.delivery_time_display = attributes[:'delivery_time_display']
      else
        self.delivery_time_display = nil
      end

      if attributes.key?(:'delivery_time_range_display')
        self.delivery_time_range_display = attributes[:'delivery_time_range_display']
      else
        self.delivery_time_range_display = nil
      end

      if attributes.key?(:'inventory_address')
        self.inventory_address = attributes[:'inventory_address']
      else
        self.inventory_address = nil
      end

      if attributes.key?(:'is_pay_at_destination')
        self.is_pay_at_destination = attributes[:'is_pay_at_destination']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      warn '[DEPRECATED] the `list_invalid_properties` method is obsolete'
      invalid_properties = Array.new
      if @id.nil?
        invalid_properties.push('invalid value for "id", id cannot be nil.')
      end

      if @name.nil?
        invalid_properties.push('invalid value for "name", name cannot be nil.')
      end

      if @name.to_s.length > 64
        invalid_properties.push('invalid value for "name", the character length must be smaller than or equal to 64.')
      end

      if @get_shipping_type_display.nil?
        invalid_properties.push('invalid value for "get_shipping_type_display", get_shipping_type_display cannot be nil.')
      end

      if @shipping_type_display.nil?
        invalid_properties.push('invalid value for "shipping_type_display", shipping_type_display cannot be nil.')
      end

      if !@cost.nil? && @cost > 2147483647
        invalid_properties.push('invalid value for "cost", must be smaller than or equal to 2147483647.')
      end

      if !@cost.nil? && @cost < 0
        invalid_properties.push('invalid value for "cost", must be greater than or equal to 0.')
      end

      if !@secondary_cost.nil? && @secondary_cost > 2147483647
        invalid_properties.push('invalid value for "secondary_cost", must be smaller than or equal to 2147483647.')
      end

      if !@secondary_cost.nil? && @secondary_cost < 0
        invalid_properties.push('invalid value for "secondary_cost", must be greater than or equal to 0.')
      end

      if !@minimum_time_sending.nil? && @minimum_time_sending > 32767
        invalid_properties.push('invalid value for "minimum_time_sending", must be smaller than or equal to 32767.')
      end

      if !@minimum_time_sending.nil? && @minimum_time_sending < 0
        invalid_properties.push('invalid value for "minimum_time_sending", must be greater than or equal to 0.')
      end

      if !@maximum_time_sending.nil? && @maximum_time_sending > 32767
        invalid_properties.push('invalid value for "maximum_time_sending", must be smaller than or equal to 32767.')
      end

      if !@maximum_time_sending.nil? && @maximum_time_sending < 0
        invalid_properties.push('invalid value for "maximum_time_sending", must be greater than or equal to 0.')
      end

      if @delivery_time_display.nil?
        invalid_properties.push('invalid value for "delivery_time_display", delivery_time_display cannot be nil.')
      end

      if @delivery_time_range_display.nil?
        invalid_properties.push('invalid value for "delivery_time_range_display", delivery_time_range_display cannot be nil.')
      end

      if @inventory_address.nil?
        invalid_properties.push('invalid value for "inventory_address", inventory_address cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      warn '[DEPRECATED] the `valid?` method is obsolete'
      return false if @id.nil?
      return false if @name.nil?
      return false if @name.to_s.length > 64
      return false if @get_shipping_type_display.nil?
      return false if @shipping_type_display.nil?
      return false if !@cost.nil? && @cost > 2147483647
      return false if !@cost.nil? && @cost < 0
      return false if !@secondary_cost.nil? && @secondary_cost > 2147483647
      return false if !@secondary_cost.nil? && @secondary_cost < 0
      return false if !@minimum_time_sending.nil? && @minimum_time_sending > 32767
      return false if !@minimum_time_sending.nil? && @minimum_time_sending < 0
      return false if !@maximum_time_sending.nil? && @maximum_time_sending > 32767
      return false if !@maximum_time_sending.nil? && @maximum_time_sending < 0
      return false if @delivery_time_display.nil?
      return false if @delivery_time_range_display.nil?
      return false if @inventory_address.nil?
      true
    end

    # Custom attribute writer method with validation
    # @param [Object] id Value to be assigned
    def id=(id)
      if id.nil?
        fail ArgumentError, 'id cannot be nil'
      end

      @id = id
    end

    # Custom attribute writer method with validation
    # @param [Object] name Value to be assigned
    def name=(name)
      if name.nil?
        fail ArgumentError, 'name cannot be nil'
      end

      if name.to_s.length > 64
        fail ArgumentError, 'invalid value for "name", the character length must be smaller than or equal to 64.'
      end

      @name = name
    end

    # Custom attribute writer method with validation
    # @param [Object] get_shipping_type_display Value to be assigned
    def get_shipping_type_display=(get_shipping_type_display)
      if get_shipping_type_display.nil?
        fail ArgumentError, 'get_shipping_type_display cannot be nil'
      end

      @get_shipping_type_display = get_shipping_type_display
    end

    # Custom attribute writer method with validation
    # @param [Object] shipping_type_display Value to be assigned
    def shipping_type_display=(shipping_type_display)
      if shipping_type_display.nil?
        fail ArgumentError, 'shipping_type_display cannot be nil'
      end

      @shipping_type_display = shipping_type_display
    end

    # Custom attribute writer method with validation
    # @param [Object] cost Value to be assigned
    def cost=(cost)
      if cost.nil?
        fail ArgumentError, 'cost cannot be nil'
      end

      if cost > 2147483647
        fail ArgumentError, 'invalid value for "cost", must be smaller than or equal to 2147483647.'
      end

      if cost < 0
        fail ArgumentError, 'invalid value for "cost", must be greater than or equal to 0.'
      end

      @cost = cost
    end

    # Custom attribute writer method with validation
    # @param [Object] secondary_cost Value to be assigned
    def secondary_cost=(secondary_cost)
      if secondary_cost.nil?
        fail ArgumentError, 'secondary_cost cannot be nil'
      end

      if secondary_cost > 2147483647
        fail ArgumentError, 'invalid value for "secondary_cost", must be smaller than or equal to 2147483647.'
      end

      if secondary_cost < 0
        fail ArgumentError, 'invalid value for "secondary_cost", must be greater than or equal to 0.'
      end

      @secondary_cost = secondary_cost
    end

    # Custom attribute writer method with validation
    # @param [Object] minimum_time_sending Value to be assigned
    def minimum_time_sending=(minimum_time_sending)
      if minimum_time_sending.nil?
        fail ArgumentError, 'minimum_time_sending cannot be nil'
      end

      if minimum_time_sending > 32767
        fail ArgumentError, 'invalid value for "minimum_time_sending", must be smaller than or equal to 32767.'
      end

      if minimum_time_sending < 0
        fail ArgumentError, 'invalid value for "minimum_time_sending", must be greater than or equal to 0.'
      end

      @minimum_time_sending = minimum_time_sending
    end

    # Custom attribute writer method with validation
    # @param [Object] maximum_time_sending Value to be assigned
    def maximum_time_sending=(maximum_time_sending)
      if maximum_time_sending.nil?
        fail ArgumentError, 'maximum_time_sending cannot be nil'
      end

      if maximum_time_sending > 32767
        fail ArgumentError, 'invalid value for "maximum_time_sending", must be smaller than or equal to 32767.'
      end

      if maximum_time_sending < 0
        fail ArgumentError, 'invalid value for "maximum_time_sending", must be greater than or equal to 0.'
      end

      @maximum_time_sending = maximum_time_sending
    end

    # Custom attribute writer method with validation
    # @param [Object] delivery_time_display Value to be assigned
    def delivery_time_display=(delivery_time_display)
      if delivery_time_display.nil?
        fail ArgumentError, 'delivery_time_display cannot be nil'
      end

      @delivery_time_display = delivery_time_display
    end

    # Custom attribute writer method with validation
    # @param [Object] delivery_time_range_display Value to be assigned
    def delivery_time_range_display=(delivery_time_range_display)
      if delivery_time_range_display.nil?
        fail ArgumentError, 'delivery_time_range_display cannot be nil'
      end

      @delivery_time_range_display = delivery_time_range_display
    end

    # Custom attribute writer method with validation
    # @param [Object] inventory_address Value to be assigned
    def inventory_address=(inventory_address)
      if inventory_address.nil?
        fail ArgumentError, 'inventory_address cannot be nil'
      end

      @inventory_address = inventory_address
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          id == o.id &&
          name == o.name &&
          description == o.description &&
          shipping_type == o.shipping_type &&
          get_shipping_type_display == o.get_shipping_type_display &&
          shipping_type_display == o.shipping_type_display &&
          cost == o.cost &&
          secondary_cost == o.secondary_cost &&
          minimum_time_sending == o.minimum_time_sending &&
          maximum_time_sending == o.maximum_time_sending &&
          delivery_time_display == o.delivery_time_display &&
          delivery_time_range_display == o.delivery_time_range_display &&
          inventory_address == o.inventory_address &&
          is_pay_at_destination == o.is_pay_at_destination
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [id, name, description, shipping_type, get_shipping_type_display, shipping_type_display, cost, secondary_cost, minimum_time_sending, maximum_time_sending, delivery_time_display, delivery_time_range_display, inventory_address, is_pay_at_destination].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def self.build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      attributes = attributes.transform_keys(&:to_sym)
      transformed_hash = {}
      openapi_types.each_pair do |key, type|
        if attributes.key?(attribute_map[key]) && attributes[attribute_map[key]].nil?
          transformed_hash["#{key}"] = nil
        elsif type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the attribute
          # is documented as an array but the input is not
          if attributes[attribute_map[key]].is_a?(Array)
            transformed_hash["#{key}"] = attributes[attribute_map[key]].map { |v| _deserialize($1, v) }
          end
        elsif !attributes[attribute_map[key]].nil?
          transformed_hash["#{key}"] = _deserialize(type, attributes[attribute_map[key]])
        end
      end
      new(transformed_hash)
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        if value.nil?
          is_nullable = self.class.openapi_nullable.include?(attr)
          next if !is_nullable || (is_nullable && !instance_variable_defined?(:"@#{attr}"))
        end

        hash[param] = _to_hash(value)
      end
      hash
    end

  end

end
