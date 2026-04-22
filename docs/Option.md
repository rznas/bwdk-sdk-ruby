# OpenapiClient::Option

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type_name** | [**TypeNameEnum**](TypeNameEnum.md) | نوع ویژگی محصول: رنگ، سایز، گارانتی، وزن یا سایر  * &#x60;color&#x60; - رنگ * &#x60;size&#x60; - اندازه * &#x60;warranty&#x60; - گارانتی * &#x60;weight&#x60; - وزن * &#x60;other&#x60; - سایر |  |
| **name** | **String** | نام ویژگی (مثلاً &#39;قرمز&#39; برای رنگ قرمز، &#39;XL&#39; برای سایز) |  |
| **value** | **String** | مقدار ویژگی (مثلاً &#39;#FF0000&#39; برای کد رنگ یا مقدار دیگر) |  |
| **is_color** | **Boolean** | اگر نوع ویژگی رنگ است درست است، وگرنه غلط | [optional][default to false] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::Option.new(
  type_name: null,
  name: null,
  value: null,
  is_color: null
)
```

