module Types
  class RepaymentAmountType < Types::BaseObject
    field :amount, Float, null: false
    field :errors, [Types::ErrorType], null: true
  end
end
