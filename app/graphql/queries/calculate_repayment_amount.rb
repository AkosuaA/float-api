require 'date'

module Queries
  class CalculateRepaymentAmount < Queries::BaseQuery
    # Monthly interest rate = 4%. Daily interest rate = 0.001333
    INTEREST_RATE = 0.001333

    description "Calculate the amount to be repaid"

    argument :amount, Float, required: true
    argument :repaying_on, GraphQL::Types::ISO8601DateTime, required: true

    type Types::RepaymentAmountType, null: false

    def resolve(amount:, repaying_on:)
      now = Date.today
      errors = []

      duration = (repaying_on.to_date - now.to_date).to_i
      
      # repayment date must be current day or more and limited to 30 days
      if duration < 0 || duration > 30
        errors << { "message" => "repayment date is invalid" }
        { amount: 0, errors: errors }
      else
        # set duration to 7 if less than a week since minimum tenure is 1 week
        duration = 7 if duration < 7

        #calculate total amount repaid: A = P * ((1 + r)**T)
        total_repaid = amount * ((1 + INTEREST_RATE)** duration)

        #convert to Naira
        total_repaid = total_repaid / 100
        {amount: total_repaid.round(2)}
      end
    end
  end
end