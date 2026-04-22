=begin
#BWDK API

#<div dir=\"rtl\" style=\"text-align: right;\">  # مستندات فروشندگان در سرویس خرید با دیجی‌کالا  این پلتفرم برای فروشندگان (مرچنت‌ها) جهت یکپارچه‌سازی خدمات پرداخت و تجارت الکترونیکی با سیستم خرید با دیجی‌کالا. شامل مدیریت سفارشات، ارسال، و احراز هویت فروشندگان است.   <div dir=\"rtl\" style=\"text-align: right;\">  <!-- ## توضیح وضعیت‌های سفارش  ### ۱. INITIAL — ایجاد اولیه سفارش  **معنا:** سفارش توسط بک‌اند مرچنت ساخته شده ولی هنوز هیچ کاربری به آن اختصاص داده نشده است.  **چگونه اتفاق می‌افتد:** مرچنت با ارسال درخواست `POST /api/v1/orders/create` و ارائه اطلاعات کالاها، مبلغ و `callback_url`، یک سفارش جدید ایجاد می‌کند. BWDK یک `order_uuid` منحصربه‌فرد و لینک شروع سفارش (`order_start_url`) برمی‌گرداند.  **وابستگی‌ها:** نیازی به کاربر یا پرداخت ندارد. فقط اطلاعات کالا از سمت مرچنت کافی است.  ---  ### ۲. STARTED — آغاز جریان خرید  **معنا:** مشتری روی لینک شروع سفارش کلیک کرده و وارد محیط BWDK شده است، اما هنوز لاگین نکرده.  **چگونه اتفاق می‌افتد:** وقتی مشتری به `order_start_url` هدایت می‌شود، BWDK وضعیت سفارش را از `INITIAL` به `STARTED` تغییر می‌دهد. در این مرحله فرآیند احراز هویت (SSO) آغاز می‌شود.  **وابستگی‌ها:** مشتری باید به لینک شروع هدایت شده باشد.  ---  ### ۳. PENDING — انتظار برای تکمیل سفارش  **معنا:** مشتری با موفقیت وارد سیستم شده و سفارش به حساب او اختصاص یافته. مشتری در حال انتخاب آدرس، روش ارسال، بسته‌بندی یا تخفیف است.  **چگونه اتفاق می‌افتد:** پس از تکمیل ورود به سیستم (SSO)، BWDK سفارش را به کاربر وصل کرده و وضعیت را به `PENDING` تغییر می‌دهد.  **وابستگی‌ها:** ورود موفق کاربر به سیستم (SSO). در این مرحله مشتری می‌تواند آدرس، شیپینگ، پکینگ و تخفیف را انتخاب کند.  ---  ### ۴. WAITING_FOR_GATEWAY — انتظار برای پرداخت  **معنا:** مشتری اطلاعات سفارش را تأیید کرده و به درگاه پرداخت هدایت شده است.  **چگونه اتفاق می‌افتد:** مشتری دکمه «پرداخت» را می‌زند (`POST /api/v1/orders/submit`)، سیستم یک رکورد پرداخت ایجاد می‌کند و کاربر به درگاه Digipay هدایت می‌شود. وضعیت سفارش به `WAITING_FOR_GATEWAY` تغییر می‌کند.  **وابستگی‌ها:** انتخاب آدرس، روش ارسال و بسته‌بندی الزامی است. پرداخت باید ایجاد شده باشد.  ---  ### ۷. PAID_BY_USER — پرداخت موفق  **معنا:** تراکنش پرداخت با موفقیت انجام شده و وجه از حساب مشتری کسر شده است.  **چگونه اتفاق می‌افتد:** درگاه پرداخت نتیجه موفق را به BWDK اطلاع می‌دهد. سیستم پرداخت را تأیید و وضعیت سفارش را به `PAID_BY_USER` تغییر می‌دهد. در این لحظه مشتری به `callback_url` مرچنت هدایت می‌شود.  **وابستگی‌ها:** تأیید موفق تراکنش از سوی درگاه پرداخت (Digipay).  ---  ### ۹. VERIFIED_BY_MERCHANT — تأیید توسط مرچنت  **معنا:** مرچنت سفارش را بررسی کرده و موجودی کالا و صحت اطلاعات را تأیید نموده است. سفارش آماده ارسال است.  **چگونه اتفاق می‌افتد:** مرچنت با ارسال درخواست `POST /api/v1/orders/manager/{uuid}/verify` سفارش را تأیید می‌کند. این مرحله **اجباری** است و باید پس از پرداخت موفق انجام شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد. مرچنت باید موجودی کالا را بررسی کند.  ---  ### ۲۰. SHIPPED — ارسال شد  **معنا:** سفارش از انبار خارج شده و در حال ارسال به مشتری است.  **چگونه اتفاق می‌افتد:** مرچنت پس از ارسال کالا، وضعیت سفارش را از طریق API به `SHIPPED` تغییر می‌دهد.  **وابستگی‌ها:** سفارش باید در وضعیت `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۹. DELIVERED — تحویل داده شد  **معنا:** سفارش به دست مشتری رسیده و فرآیند خرید به پایان رسیده است.  **چگونه اتفاق می‌افتد:** مرچنت پس از تحویل موفق، وضعیت را به `DELIVERED` تغییر می‌دهد.  **وابستگی‌ها:** سفارش باید در وضعیت `SHIPPED` باشد.  ---  ### ۵. EXPIRED — منقضی شد  **معنا:** زمان رزرو سفارش به پایان رسیده و سفارش به صورت خودکار لغو شده است.  **چگونه اتفاق می‌افتد:** یک Task دوره‌ای به طور خودکار سفارش‌هایی که `reservation_expired_at` آن‌ها گذشته را پیدا کرده و وضعیتشان را به `EXPIRED` تغییر می‌دهد. این مکانیزم مانع بلوکه شدن موجودی کالا می‌شود.  **وابستگی‌ها:** سفارش باید در یکی از وضعیت‌های `INITIAL`، `STARTED`، `PENDING` یا `WAITING_FOR_GATEWAY` باشد و زمان رزرو آن گذشته باشد.  ---  ### ۱۸. EXPIRATION_TIME_EXCEEDED — زمان انقضا گذشت  **معنا:** در لحظه ثبت نهایی یا پرداخت، مشخص شد که زمان مجاز سفارش تمام شده است.  **چگونه اتفاق می‌افتد:** هنگام ارسال درخواست پرداخت (`submit_order`)، سیستم بررسی می‌کند که `expiration_time` سفارش هنوز معتبر است یا خیر. در صورت گذشتن زمان، وضعیت به `EXPIRATION_TIME_EXCEEDED` تغییر می‌کند.  **وابستگی‌ها:** سفارش در وضعیت `PENDING` یا `WAITING_FOR_GATEWAY` است و فیلد `expiration_time` سپری شده.  ---  ### ۶. CANCELLED — لغو توسط مشتری  **معنا:** مشتری در حین فرآیند خرید (قبل از پرداخت) سفارش را لغو کرده یا از صفحه خارج شده است.  **چگونه اتفاق می‌افتد:** مشتری در صفحه checkout دکمه «انصراف» را می‌زند یا پرداخت ناموفق بوده و سفارش به حالت لغو درمی‌آید.  **وابستگی‌ها:** سفارش باید در وضعیت `PENDING` یا `WAITING_FOR_GATEWAY` باشد. پرداختی انجام نشده است.  ---  ### ۸. FAILED_TO_PAY — پرداخت ناموفق  **معنا:** تراکنش پرداخت انجام نشد یا با خطا مواجه شد.  **چگونه اتفاق می‌افتد:** درگاه پرداخت نتیجه ناموفق برمی‌گرداند یا فرآیند بازگشت وجه در مرحله پرداخت با شکست مواجه می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `WAITING_FOR_GATEWAY` بوده باشد.  ---  ### ۱۰. FAILED_TO_VERIFY_BY_MERCHANT — تأیید ناموفق توسط مرچنت  **معنا:** مرچنت سفارش را رد کرده است؛ معمولاً به دلیل ناموجود بودن کالا یا مغایرت اطلاعات.  **چگونه اتفاق می‌افتد:** مرچنت در پاسخ به درخواست verify، خطا برمی‌گرداند یا API آن وضعیت ناموفق تنظیم می‌کند. پس از این وضعیت، فرآیند استرداد وجه آغاز می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد.  ---  ### ۱۱. FAILED_BY_MERCHANT — خطا از سمت مرچنت  **معنا:** مرچنت پس از تأیید اولیه، اعلام می‌کند که قادر به انجام سفارش نیست (مثلاً به دلیل اتمام موجودی).  **چگونه اتفاق می‌افتد:** مرچنت وضعیت را به `FAILED_BY_MERCHANT` تغییر می‌دهد. وجه پرداختی مشتری مسترد خواهد شد.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` باشد.  ---  ### ۱۲. CANCELLED_BY_MERCHANT — لغو توسط مرچنت  **معنا:** مرچنت پس از پرداخت، سفارش را به هر دلیلی لغو کرده است.  **چگونه اتفاق می‌افتد:** مرچنت درخواست لغو سفارش را ارسال می‌کند. وجه پرداختی مشتری به او بازگردانده می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` یا `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۳. REQUEST_TO_REFUND — درخواست استرداد توسط مشتری  **معنا:** مشتری درخواست بازگشت وجه داده و سیستم در حال پردازش استرداد است.  **چگونه اتفاق می‌افتد:** مرچنت از طریق API درخواست استرداد را ثبت می‌کند (`POST /api/v1/orders/manager/{uuid}/refund`). سفارش وارد صف پردازش استرداد می‌شود.  **وابستگی‌ها:** سفارش باید در وضعیت `PAID_BY_USER` یا `VERIFIED_BY_MERCHANT` باشد.  ---  ### ۱۴، ۱۵، ۱۶. سایر وضعیت‌های درخواست استرداد  این وضعیت‌ها بر اساس دلیل استرداد از هم تفکیک می‌شوند:  - **۱۴ — REQUEST_TO_REFUND_TO_MERCHANT_AFTER_FAILED_TO_VERIFY:** استرداد پس از ناموفق بودن تأیید مرچنت؛ وجه به حساب مرچنت بازمی‌گردد. - **۱۵ — REQUEST_TO_REFUND_TO_CUSTOMER_AFTER_FAILED_BY_MERCHANT:** استرداد پس از خطای مرچنت؛ وجه به مشتری بازمی‌گردد. - **۱۶ — REQUEST_TO_REFUND_TO_MERCHANT_AFTER_CANCELLED_BY_MERCHANT:** استرداد پس از لغو توسط مرچنت؛ وجه به حساب مرچنت برمی‌گردد.  **چگونه اتفاق می‌افتد:** به صورت خودکار پس از رسیدن به وضعیت‌های ناموفق/لغو مربوطه توسط سیستم تنظیم می‌شود.  ---  ### ۱۷. REFUND_COMPLETED — استرداد تکمیل شد  **معنا:** وجه با موفقیت به صاحب آن (مشتری یا مرچنت بسته به نوع استرداد) بازگردانده شده است.  **چگونه اتفاق می‌افتد:** Task پردازش استرداد (`process_order_refund`) پس از تأیید موفق بازگشت وجه از سوی Digipay، وضعیت سفارش را به `REFUND_COMPLETED` تغییر می‌دهد.  **وابستگی‌ها:** یکی از وضعیت‌های درخواست استرداد (۱۳، ۱۴، ۱۵ یا ۱۶) باید فعال باشد و Digipay تراکنش استرداد را تأیید کرده باشد.  --> </div> 

The version of the OpenAPI document: 1.0.0

Generated by: https://openapi-generator.tech
Generator version: 7.21.0

=end

require 'date'
require 'time'

module OpenapiClient
  class OrderCreate < ApiModelBase
    # شناسه منحصر به فرد این سفارش در سیستم فروشنده
    attr_accessor :merchant_order_id

    # شناسه منحصر به فرد برای تأیید اصالت سفارش
    attr_accessor :merchant_unique_id

    # مجموع قیمت‌های اولیه تمام کالاها بدون تخفیف (به تومان)
    attr_accessor :main_amount

    # مبلغ نهایی: مبلغ_اصلی - مبلغ_تخفیف + مبلغ_مالیات (به تومان)
    attr_accessor :final_amount

    # مبلغ کل پرداخت شده توسط کاربر: مبلغ_نهایی + هزینه_ارسال (به تومان)
    attr_accessor :total_paid_amount

    # مبلغ کل تخفیف برای تمام سفارش (به تومان)
    attr_accessor :discount_amount

    # مبلغ کل مالیات برای تمام سفارش (به تومان)
    attr_accessor :tax_amount

    # هزینه ارسال برای سفارش (به تومان)
    attr_accessor :shipping_amount

    # مبلغ تخفیف باشگاه مشتریان/پاداش (به تومان)
    attr_accessor :loyalty_amount

    # آدرس وب‌هوک برای دریافت اطلاع رسانی وضعیت پرداخت
    attr_accessor :callback_url

    attr_accessor :destination_address

    attr_accessor :items

    # مقدار توسط سیستم جایگذاری می شود
    attr_accessor :merchant

    # مقدار توسط سیستم جایگذاری می شود
    attr_accessor :source_address

    attr_accessor :user

    # مهلت پرداخت (به عنوان Unix timestamp) قبل از اتمام سفارش
    attr_accessor :reservation_expired_at

    # کد مرجع یکتا برای پیگیری سفارش مشتری (قالب: BD-XXXXXXXX)
    attr_accessor :reference_code

    # Preparation time for the order (in days)
    attr_accessor :preparation_time

    # Total Weight of the order (in grams)
    attr_accessor :weight

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'merchant_order_id' => :'merchant_order_id',
        :'merchant_unique_id' => :'merchant_unique_id',
        :'main_amount' => :'main_amount',
        :'final_amount' => :'final_amount',
        :'total_paid_amount' => :'total_paid_amount',
        :'discount_amount' => :'discount_amount',
        :'tax_amount' => :'tax_amount',
        :'shipping_amount' => :'shipping_amount',
        :'loyalty_amount' => :'loyalty_amount',
        :'callback_url' => :'callback_url',
        :'destination_address' => :'destination_address',
        :'items' => :'items',
        :'merchant' => :'merchant',
        :'source_address' => :'source_address',
        :'user' => :'user',
        :'reservation_expired_at' => :'reservation_expired_at',
        :'reference_code' => :'reference_code',
        :'preparation_time' => :'preparation_time',
        :'weight' => :'weight'
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
        :'merchant_order_id' => :'String',
        :'merchant_unique_id' => :'String',
        :'main_amount' => :'Integer',
        :'final_amount' => :'Integer',
        :'total_paid_amount' => :'Integer',
        :'discount_amount' => :'Integer',
        :'tax_amount' => :'Integer',
        :'shipping_amount' => :'Integer',
        :'loyalty_amount' => :'Integer',
        :'callback_url' => :'String',
        :'destination_address' => :'Object',
        :'items' => :'Array<OrderItemCreate>',
        :'merchant' => :'Integer',
        :'source_address' => :'Object',
        :'user' => :'Integer',
        :'reservation_expired_at' => :'Integer',
        :'reference_code' => :'String',
        :'preparation_time' => :'Integer',
        :'weight' => :'Float'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'destination_address',
        :'source_address',
        :'user',
        :'reservation_expired_at',
      ])
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `OpenapiClient::OrderCreate` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      acceptable_attribute_map = self.class.acceptable_attribute_map
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!acceptable_attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `OpenapiClient::OrderCreate`. Please check the name to make sure it's valid. List of attributes: " + acceptable_attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'merchant_order_id')
        self.merchant_order_id = attributes[:'merchant_order_id']
      else
        self.merchant_order_id = nil
      end

      if attributes.key?(:'merchant_unique_id')
        self.merchant_unique_id = attributes[:'merchant_unique_id']
      else
        self.merchant_unique_id = nil
      end

      if attributes.key?(:'main_amount')
        self.main_amount = attributes[:'main_amount']
      end

      if attributes.key?(:'final_amount')
        self.final_amount = attributes[:'final_amount']
      end

      if attributes.key?(:'total_paid_amount')
        self.total_paid_amount = attributes[:'total_paid_amount']
      end

      if attributes.key?(:'discount_amount')
        self.discount_amount = attributes[:'discount_amount']
      end

      if attributes.key?(:'tax_amount')
        self.tax_amount = attributes[:'tax_amount']
      end

      if attributes.key?(:'shipping_amount')
        self.shipping_amount = attributes[:'shipping_amount']
      end

      if attributes.key?(:'loyalty_amount')
        self.loyalty_amount = attributes[:'loyalty_amount']
      end

      if attributes.key?(:'callback_url')
        self.callback_url = attributes[:'callback_url']
      else
        self.callback_url = nil
      end

      if attributes.key?(:'destination_address')
        self.destination_address = attributes[:'destination_address']
      else
        self.destination_address = nil
      end

      if attributes.key?(:'items')
        if (value = attributes[:'items']).is_a?(Array)
          self.items = value
        end
      else
        self.items = nil
      end

      if attributes.key?(:'merchant')
        self.merchant = attributes[:'merchant']
      end

      if attributes.key?(:'source_address')
        self.source_address = attributes[:'source_address']
      end

      if attributes.key?(:'user')
        self.user = attributes[:'user']
      else
        self.user = nil
      end

      if attributes.key?(:'reservation_expired_at')
        self.reservation_expired_at = attributes[:'reservation_expired_at']
      end

      if attributes.key?(:'reference_code')
        self.reference_code = attributes[:'reference_code']
      else
        self.reference_code = nil
      end

      if attributes.key?(:'preparation_time')
        self.preparation_time = attributes[:'preparation_time']
      else
        self.preparation_time = 2
      end

      if attributes.key?(:'weight')
        self.weight = attributes[:'weight']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      warn '[DEPRECATED] the `list_invalid_properties` method is obsolete'
      invalid_properties = Array.new
      if @merchant_order_id.nil?
        invalid_properties.push('invalid value for "merchant_order_id", merchant_order_id cannot be nil.')
      end

      if @merchant_order_id.to_s.length > 64
        invalid_properties.push('invalid value for "merchant_order_id", the character length must be smaller than or equal to 64.')
      end

      if @merchant_unique_id.nil?
        invalid_properties.push('invalid value for "merchant_unique_id", merchant_unique_id cannot be nil.')
      end

      if @merchant_unique_id.to_s.length > 64
        invalid_properties.push('invalid value for "merchant_unique_id", the character length must be smaller than or equal to 64.')
      end

      if !@main_amount.nil? && @main_amount > 2147483647
        invalid_properties.push('invalid value for "main_amount", must be smaller than or equal to 2147483647.')
      end

      if !@main_amount.nil? && @main_amount < 0
        invalid_properties.push('invalid value for "main_amount", must be greater than or equal to 0.')
      end

      if !@final_amount.nil? && @final_amount > 2147483647
        invalid_properties.push('invalid value for "final_amount", must be smaller than or equal to 2147483647.')
      end

      if !@final_amount.nil? && @final_amount < 0
        invalid_properties.push('invalid value for "final_amount", must be greater than or equal to 0.')
      end

      if !@total_paid_amount.nil? && @total_paid_amount > 2147483647
        invalid_properties.push('invalid value for "total_paid_amount", must be smaller than or equal to 2147483647.')
      end

      if !@total_paid_amount.nil? && @total_paid_amount < 0
        invalid_properties.push('invalid value for "total_paid_amount", must be greater than or equal to 0.')
      end

      if !@discount_amount.nil? && @discount_amount > 2147483647
        invalid_properties.push('invalid value for "discount_amount", must be smaller than or equal to 2147483647.')
      end

      if !@discount_amount.nil? && @discount_amount < 0
        invalid_properties.push('invalid value for "discount_amount", must be greater than or equal to 0.')
      end

      if !@tax_amount.nil? && @tax_amount > 2147483647
        invalid_properties.push('invalid value for "tax_amount", must be smaller than or equal to 2147483647.')
      end

      if !@tax_amount.nil? && @tax_amount < 0
        invalid_properties.push('invalid value for "tax_amount", must be greater than or equal to 0.')
      end

      if !@shipping_amount.nil? && @shipping_amount > 2147483647
        invalid_properties.push('invalid value for "shipping_amount", must be smaller than or equal to 2147483647.')
      end

      if !@shipping_amount.nil? && @shipping_amount < 0
        invalid_properties.push('invalid value for "shipping_amount", must be greater than or equal to 0.')
      end

      if !@loyalty_amount.nil? && @loyalty_amount > 2147483647
        invalid_properties.push('invalid value for "loyalty_amount", must be smaller than or equal to 2147483647.')
      end

      if !@loyalty_amount.nil? && @loyalty_amount < 0
        invalid_properties.push('invalid value for "loyalty_amount", must be greater than or equal to 0.')
      end

      if @callback_url.nil?
        invalid_properties.push('invalid value for "callback_url", callback_url cannot be nil.')
      end

      if @callback_url.to_s.length > 256
        invalid_properties.push('invalid value for "callback_url", the character length must be smaller than or equal to 256.')
      end

      if @items.nil?
        invalid_properties.push('invalid value for "items", items cannot be nil.')
      end

      if !@reservation_expired_at.nil? && @reservation_expired_at > 2147483647
        invalid_properties.push('invalid value for "reservation_expired_at", must be smaller than or equal to 2147483647.')
      end

      if !@reservation_expired_at.nil? && @reservation_expired_at < 0
        invalid_properties.push('invalid value for "reservation_expired_at", must be greater than or equal to 0.')
      end

      if @reference_code.nil?
        invalid_properties.push('invalid value for "reference_code", reference_code cannot be nil.')
      end

      if !@preparation_time.nil? && @preparation_time < 0
        invalid_properties.push('invalid value for "preparation_time", must be greater than or equal to 0.')
      end

      if !@weight.nil? && @weight < 0
        invalid_properties.push('invalid value for "weight", must be greater than or equal to 0.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      warn '[DEPRECATED] the `valid?` method is obsolete'
      return false if @merchant_order_id.nil?
      return false if @merchant_order_id.to_s.length > 64
      return false if @merchant_unique_id.nil?
      return false if @merchant_unique_id.to_s.length > 64
      return false if !@main_amount.nil? && @main_amount > 2147483647
      return false if !@main_amount.nil? && @main_amount < 0
      return false if !@final_amount.nil? && @final_amount > 2147483647
      return false if !@final_amount.nil? && @final_amount < 0
      return false if !@total_paid_amount.nil? && @total_paid_amount > 2147483647
      return false if !@total_paid_amount.nil? && @total_paid_amount < 0
      return false if !@discount_amount.nil? && @discount_amount > 2147483647
      return false if !@discount_amount.nil? && @discount_amount < 0
      return false if !@tax_amount.nil? && @tax_amount > 2147483647
      return false if !@tax_amount.nil? && @tax_amount < 0
      return false if !@shipping_amount.nil? && @shipping_amount > 2147483647
      return false if !@shipping_amount.nil? && @shipping_amount < 0
      return false if !@loyalty_amount.nil? && @loyalty_amount > 2147483647
      return false if !@loyalty_amount.nil? && @loyalty_amount < 0
      return false if @callback_url.nil?
      return false if @callback_url.to_s.length > 256
      return false if @items.nil?
      return false if !@reservation_expired_at.nil? && @reservation_expired_at > 2147483647
      return false if !@reservation_expired_at.nil? && @reservation_expired_at < 0
      return false if @reference_code.nil?
      return false if !@preparation_time.nil? && @preparation_time < 0
      return false if !@weight.nil? && @weight < 0
      true
    end

    # Custom attribute writer method with validation
    # @param [Object] merchant_order_id Value to be assigned
    def merchant_order_id=(merchant_order_id)
      if merchant_order_id.nil?
        fail ArgumentError, 'merchant_order_id cannot be nil'
      end

      if merchant_order_id.to_s.length > 64
        fail ArgumentError, 'invalid value for "merchant_order_id", the character length must be smaller than or equal to 64.'
      end

      @merchant_order_id = merchant_order_id
    end

    # Custom attribute writer method with validation
    # @param [Object] merchant_unique_id Value to be assigned
    def merchant_unique_id=(merchant_unique_id)
      if merchant_unique_id.nil?
        fail ArgumentError, 'merchant_unique_id cannot be nil'
      end

      if merchant_unique_id.to_s.length > 64
        fail ArgumentError, 'invalid value for "merchant_unique_id", the character length must be smaller than or equal to 64.'
      end

      @merchant_unique_id = merchant_unique_id
    end

    # Custom attribute writer method with validation
    # @param [Object] main_amount Value to be assigned
    def main_amount=(main_amount)
      if main_amount.nil?
        fail ArgumentError, 'main_amount cannot be nil'
      end

      if main_amount > 2147483647
        fail ArgumentError, 'invalid value for "main_amount", must be smaller than or equal to 2147483647.'
      end

      if main_amount < 0
        fail ArgumentError, 'invalid value for "main_amount", must be greater than or equal to 0.'
      end

      @main_amount = main_amount
    end

    # Custom attribute writer method with validation
    # @param [Object] final_amount Value to be assigned
    def final_amount=(final_amount)
      if final_amount.nil?
        fail ArgumentError, 'final_amount cannot be nil'
      end

      if final_amount > 2147483647
        fail ArgumentError, 'invalid value for "final_amount", must be smaller than or equal to 2147483647.'
      end

      if final_amount < 0
        fail ArgumentError, 'invalid value for "final_amount", must be greater than or equal to 0.'
      end

      @final_amount = final_amount
    end

    # Custom attribute writer method with validation
    # @param [Object] total_paid_amount Value to be assigned
    def total_paid_amount=(total_paid_amount)
      if total_paid_amount.nil?
        fail ArgumentError, 'total_paid_amount cannot be nil'
      end

      if total_paid_amount > 2147483647
        fail ArgumentError, 'invalid value for "total_paid_amount", must be smaller than or equal to 2147483647.'
      end

      if total_paid_amount < 0
        fail ArgumentError, 'invalid value for "total_paid_amount", must be greater than or equal to 0.'
      end

      @total_paid_amount = total_paid_amount
    end

    # Custom attribute writer method with validation
    # @param [Object] discount_amount Value to be assigned
    def discount_amount=(discount_amount)
      if discount_amount.nil?
        fail ArgumentError, 'discount_amount cannot be nil'
      end

      if discount_amount > 2147483647
        fail ArgumentError, 'invalid value for "discount_amount", must be smaller than or equal to 2147483647.'
      end

      if discount_amount < 0
        fail ArgumentError, 'invalid value for "discount_amount", must be greater than or equal to 0.'
      end

      @discount_amount = discount_amount
    end

    # Custom attribute writer method with validation
    # @param [Object] tax_amount Value to be assigned
    def tax_amount=(tax_amount)
      if tax_amount.nil?
        fail ArgumentError, 'tax_amount cannot be nil'
      end

      if tax_amount > 2147483647
        fail ArgumentError, 'invalid value for "tax_amount", must be smaller than or equal to 2147483647.'
      end

      if tax_amount < 0
        fail ArgumentError, 'invalid value for "tax_amount", must be greater than or equal to 0.'
      end

      @tax_amount = tax_amount
    end

    # Custom attribute writer method with validation
    # @param [Object] shipping_amount Value to be assigned
    def shipping_amount=(shipping_amount)
      if shipping_amount.nil?
        fail ArgumentError, 'shipping_amount cannot be nil'
      end

      if shipping_amount > 2147483647
        fail ArgumentError, 'invalid value for "shipping_amount", must be smaller than or equal to 2147483647.'
      end

      if shipping_amount < 0
        fail ArgumentError, 'invalid value for "shipping_amount", must be greater than or equal to 0.'
      end

      @shipping_amount = shipping_amount
    end

    # Custom attribute writer method with validation
    # @param [Object] loyalty_amount Value to be assigned
    def loyalty_amount=(loyalty_amount)
      if loyalty_amount.nil?
        fail ArgumentError, 'loyalty_amount cannot be nil'
      end

      if loyalty_amount > 2147483647
        fail ArgumentError, 'invalid value for "loyalty_amount", must be smaller than or equal to 2147483647.'
      end

      if loyalty_amount < 0
        fail ArgumentError, 'invalid value for "loyalty_amount", must be greater than or equal to 0.'
      end

      @loyalty_amount = loyalty_amount
    end

    # Custom attribute writer method with validation
    # @param [Object] callback_url Value to be assigned
    def callback_url=(callback_url)
      if callback_url.nil?
        fail ArgumentError, 'callback_url cannot be nil'
      end

      if callback_url.to_s.length > 256
        fail ArgumentError, 'invalid value for "callback_url", the character length must be smaller than or equal to 256.'
      end

      @callback_url = callback_url
    end

    # Custom attribute writer method with validation
    # @param [Object] items Value to be assigned
    def items=(items)
      if items.nil?
        fail ArgumentError, 'items cannot be nil'
      end

      @items = items
    end

    # Custom attribute writer method with validation
    # @param [Object] reservation_expired_at Value to be assigned
    def reservation_expired_at=(reservation_expired_at)
      if !reservation_expired_at.nil? && reservation_expired_at > 2147483647
        fail ArgumentError, 'invalid value for "reservation_expired_at", must be smaller than or equal to 2147483647.'
      end

      if !reservation_expired_at.nil? && reservation_expired_at < 0
        fail ArgumentError, 'invalid value for "reservation_expired_at", must be greater than or equal to 0.'
      end

      @reservation_expired_at = reservation_expired_at
    end

    # Custom attribute writer method with validation
    # @param [Object] reference_code Value to be assigned
    def reference_code=(reference_code)
      if reference_code.nil?
        fail ArgumentError, 'reference_code cannot be nil'
      end

      @reference_code = reference_code
    end

    # Custom attribute writer method with validation
    # @param [Object] preparation_time Value to be assigned
    def preparation_time=(preparation_time)
      if preparation_time.nil?
        fail ArgumentError, 'preparation_time cannot be nil'
      end

      if preparation_time < 0
        fail ArgumentError, 'invalid value for "preparation_time", must be greater than or equal to 0.'
      end

      @preparation_time = preparation_time
    end

    # Custom attribute writer method with validation
    # @param [Object] weight Value to be assigned
    def weight=(weight)
      if weight.nil?
        fail ArgumentError, 'weight cannot be nil'
      end

      if weight < 0
        fail ArgumentError, 'invalid value for "weight", must be greater than or equal to 0.'
      end

      @weight = weight
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          merchant_order_id == o.merchant_order_id &&
          merchant_unique_id == o.merchant_unique_id &&
          main_amount == o.main_amount &&
          final_amount == o.final_amount &&
          total_paid_amount == o.total_paid_amount &&
          discount_amount == o.discount_amount &&
          tax_amount == o.tax_amount &&
          shipping_amount == o.shipping_amount &&
          loyalty_amount == o.loyalty_amount &&
          callback_url == o.callback_url &&
          destination_address == o.destination_address &&
          items == o.items &&
          merchant == o.merchant &&
          source_address == o.source_address &&
          user == o.user &&
          reservation_expired_at == o.reservation_expired_at &&
          reference_code == o.reference_code &&
          preparation_time == o.preparation_time &&
          weight == o.weight
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [merchant_order_id, merchant_unique_id, main_amount, final_amount, total_paid_amount, discount_amount, tax_amount, shipping_amount, loyalty_amount, callback_url, destination_address, items, merchant, source_address, user, reservation_expired_at, reference_code, preparation_time, weight].hash
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
