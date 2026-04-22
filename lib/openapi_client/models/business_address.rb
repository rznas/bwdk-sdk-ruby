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
  # Serializer for BusinessAddress model. Used for merchant and shipping addresses.
  class BusinessAddress < ApiModelBase
    attr_accessor :id

    attr_accessor :address

    attr_accessor :postal_code

    attr_accessor :city_name

    attr_accessor :state_name

    attr_accessor :district_id

    attr_accessor :district_name

    attr_accessor :longitude

    attr_accessor :latitude

    attr_accessor :building_number

    attr_accessor :unit

    attr_accessor :receiver_name

    attr_accessor :receiver_phone

    attr_accessor :is_accurate

    attr_accessor :is_active

    attr_accessor :created_at

    attr_accessor :modified_at

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'address' => :'address',
        :'postal_code' => :'postal_code',
        :'city_name' => :'city_name',
        :'state_name' => :'state_name',
        :'district_id' => :'district_id',
        :'district_name' => :'district_name',
        :'longitude' => :'longitude',
        :'latitude' => :'latitude',
        :'building_number' => :'building_number',
        :'unit' => :'unit',
        :'receiver_name' => :'receiver_name',
        :'receiver_phone' => :'receiver_phone',
        :'is_accurate' => :'is_accurate',
        :'is_active' => :'is_active',
        :'created_at' => :'created_at',
        :'modified_at' => :'modified_at'
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
        :'address' => :'String',
        :'postal_code' => :'String',
        :'city_name' => :'String',
        :'state_name' => :'String',
        :'district_id' => :'Integer',
        :'district_name' => :'String',
        :'longitude' => :'Float',
        :'latitude' => :'Float',
        :'building_number' => :'String',
        :'unit' => :'String',
        :'receiver_name' => :'String',
        :'receiver_phone' => :'String',
        :'is_accurate' => :'Boolean',
        :'is_active' => :'Boolean',
        :'created_at' => :'Time',
        :'modified_at' => :'Time'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'postal_code',
        :'district_id',
        :'district_name',
        :'longitude',
        :'latitude',
        :'building_number',
        :'unit',
        :'receiver_name',
        :'receiver_phone',
      ])
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `OpenapiClient::BusinessAddress` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      acceptable_attribute_map = self.class.acceptable_attribute_map
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!acceptable_attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `OpenapiClient::BusinessAddress`. Please check the name to make sure it's valid. List of attributes: " + acceptable_attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'id')
        self.id = attributes[:'id']
      else
        self.id = nil
      end

      if attributes.key?(:'address')
        self.address = attributes[:'address']
      else
        self.address = nil
      end

      if attributes.key?(:'postal_code')
        self.postal_code = attributes[:'postal_code']
      end

      if attributes.key?(:'city_name')
        self.city_name = attributes[:'city_name']
      else
        self.city_name = nil
      end

      if attributes.key?(:'state_name')
        self.state_name = attributes[:'state_name']
      else
        self.state_name = nil
      end

      if attributes.key?(:'district_id')
        self.district_id = attributes[:'district_id']
      end

      if attributes.key?(:'district_name')
        self.district_name = attributes[:'district_name']
      end

      if attributes.key?(:'longitude')
        self.longitude = attributes[:'longitude']
      end

      if attributes.key?(:'latitude')
        self.latitude = attributes[:'latitude']
      end

      if attributes.key?(:'building_number')
        self.building_number = attributes[:'building_number']
      end

      if attributes.key?(:'unit')
        self.unit = attributes[:'unit']
      end

      if attributes.key?(:'receiver_name')
        self.receiver_name = attributes[:'receiver_name']
      end

      if attributes.key?(:'receiver_phone')
        self.receiver_phone = attributes[:'receiver_phone']
      end

      if attributes.key?(:'is_accurate')
        self.is_accurate = attributes[:'is_accurate']
      end

      if attributes.key?(:'is_active')
        self.is_active = attributes[:'is_active']
      end

      if attributes.key?(:'created_at')
        self.created_at = attributes[:'created_at']
      else
        self.created_at = nil
      end

      if attributes.key?(:'modified_at')
        self.modified_at = attributes[:'modified_at']
      else
        self.modified_at = nil
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

      if @address.nil?
        invalid_properties.push('invalid value for "address", address cannot be nil.')
      end

      if !@postal_code.nil? && @postal_code.to_s.length > 10
        invalid_properties.push('invalid value for "postal_code", the character length must be smaller than or equal to 10.')
      end

      if @city_name.nil?
        invalid_properties.push('invalid value for "city_name", city_name cannot be nil.')
      end

      if @city_name.to_s.length > 32
        invalid_properties.push('invalid value for "city_name", the character length must be smaller than or equal to 32.')
      end

      if @state_name.nil?
        invalid_properties.push('invalid value for "state_name", state_name cannot be nil.')
      end

      if @state_name.to_s.length > 32
        invalid_properties.push('invalid value for "state_name", the character length must be smaller than or equal to 32.')
      end

      if !@district_id.nil? && @district_id > 2147483647
        invalid_properties.push('invalid value for "district_id", must be smaller than or equal to 2147483647.')
      end

      if !@district_id.nil? && @district_id < 0
        invalid_properties.push('invalid value for "district_id", must be greater than or equal to 0.')
      end

      if !@district_name.nil? && @district_name.to_s.length > 32
        invalid_properties.push('invalid value for "district_name", the character length must be smaller than or equal to 32.')
      end

      pattern = Regexp.new(/^-?\d{0,6}(?:\.\d{0,16})?$/)
      if !@longitude.nil? && @longitude !~ pattern
        invalid_properties.push("invalid value for \"longitude\", must conform to the pattern #{pattern}.")
      end

      pattern = Regexp.new(/^-?\d{0,6}(?:\.\d{0,16})?$/)
      if !@latitude.nil? && @latitude !~ pattern
        invalid_properties.push("invalid value for \"latitude\", must conform to the pattern #{pattern}.")
      end

      if !@building_number.nil? && @building_number.to_s.length > 10
        invalid_properties.push('invalid value for "building_number", the character length must be smaller than or equal to 10.')
      end

      if !@unit.nil? && @unit.to_s.length > 50
        invalid_properties.push('invalid value for "unit", the character length must be smaller than or equal to 50.')
      end

      if !@receiver_name.nil? && @receiver_name.to_s.length > 100
        invalid_properties.push('invalid value for "receiver_name", the character length must be smaller than or equal to 100.')
      end

      if !@receiver_phone.nil? && @receiver_phone.to_s.length > 100
        invalid_properties.push('invalid value for "receiver_phone", the character length must be smaller than or equal to 100.')
      end

      if @created_at.nil?
        invalid_properties.push('invalid value for "created_at", created_at cannot be nil.')
      end

      if @modified_at.nil?
        invalid_properties.push('invalid value for "modified_at", modified_at cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      warn '[DEPRECATED] the `valid?` method is obsolete'
      return false if @id.nil?
      return false if @address.nil?
      return false if !@postal_code.nil? && @postal_code.to_s.length > 10
      return false if @city_name.nil?
      return false if @city_name.to_s.length > 32
      return false if @state_name.nil?
      return false if @state_name.to_s.length > 32
      return false if !@district_id.nil? && @district_id > 2147483647
      return false if !@district_id.nil? && @district_id < 0
      return false if !@district_name.nil? && @district_name.to_s.length > 32
      return false if !@longitude.nil? && @longitude !~ Regexp.new(/^-?\d{0,6}(?:\.\d{0,16})?$/)
      return false if !@latitude.nil? && @latitude !~ Regexp.new(/^-?\d{0,6}(?:\.\d{0,16})?$/)
      return false if !@building_number.nil? && @building_number.to_s.length > 10
      return false if !@unit.nil? && @unit.to_s.length > 50
      return false if !@receiver_name.nil? && @receiver_name.to_s.length > 100
      return false if !@receiver_phone.nil? && @receiver_phone.to_s.length > 100
      return false if @created_at.nil?
      return false if @modified_at.nil?
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
    # @param [Object] address Value to be assigned
    def address=(address)
      if address.nil?
        fail ArgumentError, 'address cannot be nil'
      end

      @address = address
    end

    # Custom attribute writer method with validation
    # @param [Object] postal_code Value to be assigned
    def postal_code=(postal_code)
      if !postal_code.nil? && postal_code.to_s.length > 10
        fail ArgumentError, 'invalid value for "postal_code", the character length must be smaller than or equal to 10.'
      end

      @postal_code = postal_code
    end

    # Custom attribute writer method with validation
    # @param [Object] city_name Value to be assigned
    def city_name=(city_name)
      if city_name.nil?
        fail ArgumentError, 'city_name cannot be nil'
      end

      if city_name.to_s.length > 32
        fail ArgumentError, 'invalid value for "city_name", the character length must be smaller than or equal to 32.'
      end

      @city_name = city_name
    end

    # Custom attribute writer method with validation
    # @param [Object] state_name Value to be assigned
    def state_name=(state_name)
      if state_name.nil?
        fail ArgumentError, 'state_name cannot be nil'
      end

      if state_name.to_s.length > 32
        fail ArgumentError, 'invalid value for "state_name", the character length must be smaller than or equal to 32.'
      end

      @state_name = state_name
    end

    # Custom attribute writer method with validation
    # @param [Object] district_id Value to be assigned
    def district_id=(district_id)
      if !district_id.nil? && district_id > 2147483647
        fail ArgumentError, 'invalid value for "district_id", must be smaller than or equal to 2147483647.'
      end

      if !district_id.nil? && district_id < 0
        fail ArgumentError, 'invalid value for "district_id", must be greater than or equal to 0.'
      end

      @district_id = district_id
    end

    # Custom attribute writer method with validation
    # @param [Object] district_name Value to be assigned
    def district_name=(district_name)
      if !district_name.nil? && district_name.to_s.length > 32
        fail ArgumentError, 'invalid value for "district_name", the character length must be smaller than or equal to 32.'
      end

      @district_name = district_name
    end

    # Custom attribute writer method with validation
    # @param [Object] longitude Value to be assigned
    def longitude=(longitude)
      pattern = Regexp.new(/^-?\d{0,6}(?:\.\d{0,16})?$/)
      if !longitude.nil? && longitude !~ pattern
        fail ArgumentError, "invalid value for \"longitude\", must conform to the pattern #{pattern}."
      end

      @longitude = longitude
    end

    # Custom attribute writer method with validation
    # @param [Object] latitude Value to be assigned
    def latitude=(latitude)
      pattern = Regexp.new(/^-?\d{0,6}(?:\.\d{0,16})?$/)
      if !latitude.nil? && latitude !~ pattern
        fail ArgumentError, "invalid value for \"latitude\", must conform to the pattern #{pattern}."
      end

      @latitude = latitude
    end

    # Custom attribute writer method with validation
    # @param [Object] building_number Value to be assigned
    def building_number=(building_number)
      if !building_number.nil? && building_number.to_s.length > 10
        fail ArgumentError, 'invalid value for "building_number", the character length must be smaller than or equal to 10.'
      end

      @building_number = building_number
    end

    # Custom attribute writer method with validation
    # @param [Object] unit Value to be assigned
    def unit=(unit)
      if !unit.nil? && unit.to_s.length > 50
        fail ArgumentError, 'invalid value for "unit", the character length must be smaller than or equal to 50.'
      end

      @unit = unit
    end

    # Custom attribute writer method with validation
    # @param [Object] receiver_name Value to be assigned
    def receiver_name=(receiver_name)
      if !receiver_name.nil? && receiver_name.to_s.length > 100
        fail ArgumentError, 'invalid value for "receiver_name", the character length must be smaller than or equal to 100.'
      end

      @receiver_name = receiver_name
    end

    # Custom attribute writer method with validation
    # @param [Object] receiver_phone Value to be assigned
    def receiver_phone=(receiver_phone)
      if !receiver_phone.nil? && receiver_phone.to_s.length > 100
        fail ArgumentError, 'invalid value for "receiver_phone", the character length must be smaller than or equal to 100.'
      end

      @receiver_phone = receiver_phone
    end

    # Custom attribute writer method with validation
    # @param [Object] created_at Value to be assigned
    def created_at=(created_at)
      if created_at.nil?
        fail ArgumentError, 'created_at cannot be nil'
      end

      @created_at = created_at
    end

    # Custom attribute writer method with validation
    # @param [Object] modified_at Value to be assigned
    def modified_at=(modified_at)
      if modified_at.nil?
        fail ArgumentError, 'modified_at cannot be nil'
      end

      @modified_at = modified_at
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          id == o.id &&
          address == o.address &&
          postal_code == o.postal_code &&
          city_name == o.city_name &&
          state_name == o.state_name &&
          district_id == o.district_id &&
          district_name == o.district_name &&
          longitude == o.longitude &&
          latitude == o.latitude &&
          building_number == o.building_number &&
          unit == o.unit &&
          receiver_name == o.receiver_name &&
          receiver_phone == o.receiver_phone &&
          is_accurate == o.is_accurate &&
          is_active == o.is_active &&
          created_at == o.created_at &&
          modified_at == o.modified_at
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [id, address, postal_code, city_name, state_name, district_id, district_name, longitude, latitude, building_number, unit, receiver_name, receiver_phone, is_accurate, is_active, created_at, modified_at].hash
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
