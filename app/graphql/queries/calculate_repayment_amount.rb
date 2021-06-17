require 'date'

module Queries
  class CalculateRepaymentAmount < Queries::BaseQuery
    INTEREST_RATE = 0.00133
    description "Calculate the amount to be repaid"

    argument :amount, Float, required: true
    argument :repaying_on, GraphQL::Types::ISO8601DateTime, required: true

    type Types::RepaymentAmountType, null: false

    def resolve(amount:, repaying_on:)
      now = Date.today
      errors = []

      duration = (repaying_on.to_date - now.to_date).to_i
      
      if duration < 0
        errors << "repayment date is invalid"
        { amount: 0, errors: errors }
      else
        duration = 7 if duration < 7
        amount = (amount + ( amount * (((1 + INTEREST_RATE) ** duration) - 1)))/100
        {amount: amount.round(2)}
      end
    end
  end
end