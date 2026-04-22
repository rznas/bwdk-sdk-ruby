# OpenapiClient::WalletBalance

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **amount** | **Integer** | Current wallet balance in Tomans | [optional] |
| **negative_settlement_deadline** | **String** | Deadline for settling negative balance | [readonly] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::WalletBalance.new(
  amount: null,
  negative_settlement_deadline: null
)
```

