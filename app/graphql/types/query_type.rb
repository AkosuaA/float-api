module Types
  class QueryType < Types::BaseObject
    field :calculate_repayment_amount, resolver: Queries::CalculateRepaymentAmount

  end
end
