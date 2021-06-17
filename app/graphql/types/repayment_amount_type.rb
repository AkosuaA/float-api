module Types
  class RepaymentAmountType < Types::BaseObject
    field :amount, Float, null: false
    field :errors, [String], null: true
  end
end
