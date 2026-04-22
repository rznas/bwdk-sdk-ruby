# OpenapiClient::PaginatedMerchantPaidOrderListList

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **_next** | **String** |  | [optional] |
| **previous** | **String** |  | [optional] |
| **results** | [**Array&lt;MerchantPaidOrderList&gt;**](MerchantPaidOrderList.md) |  |  |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::PaginatedMerchantPaidOrderListList.new(
  _next: http://api.example.org/accounts/?cursor&#x3D;cD00ODY%3D&quot;,
  previous: http://api.example.org/accounts/?cursor&#x3D;cj0xJnA9NDg3,
  results: null
)
```

