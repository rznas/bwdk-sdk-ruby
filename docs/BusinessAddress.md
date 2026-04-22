# OpenapiClient::BusinessAddress

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** |  | [readonly] |
| **address** | **String** |  |  |
| **postal_code** | **String** |  | [optional] |
| **city_name** | **String** |  |  |
| **state_name** | **String** |  |  |
| **district_id** | **Integer** |  | [optional] |
| **district_name** | **String** |  | [optional] |
| **longitude** | **Float** |  | [optional] |
| **latitude** | **Float** |  | [optional] |
| **building_number** | **String** |  | [optional] |
| **unit** | **String** |  | [optional] |
| **receiver_name** | **String** |  | [optional] |
| **receiver_phone** | **String** |  | [optional] |
| **is_accurate** | **Boolean** |  | [optional] |
| **is_active** | **Boolean** |  | [optional] |
| **created_at** | **Time** |  | [readonly] |
| **modified_at** | **Time** |  | [readonly] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::BusinessAddress.new(
  id: null,
  address: null,
  postal_code: null,
  city_name: null,
  state_name: null,
  district_id: null,
  district_name: null,
  longitude: null,
  latitude: null,
  building_number: null,
  unit: null,
  receiver_name: null,
  receiver_phone: null,
  is_accurate: null,
  is_active: null,
  created_at: null,
  modified_at: null
)
```

