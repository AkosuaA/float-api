require 'rails_helper'
require 'date'
module Queries
  RSpec.describe CalculateRepaymentAmount, type: :request do
    describe '.resolve' do
      it 'successfully returns the repayment amount' do

        now = (Date.today + 24.days).to_date
        post '/graphql', params: { query: query(amount: 240000, repaying_on: now.to_s) }

        json = JSON.parse(response.body)
        data = json['data']['calculateRepaymentAmount']

        expect(data).to include(
          'amount' => be_present,
          'errors' => nil
        )
      end

      it 'successfully returns the repayment amount (edge-case: same day)' do
        now = Date.today.to_date
        post '/graphql', params: { query: query(amount: 240000, repaying_on: now.to_s) }

        json = JSON.parse(response.body)
        data = json['data']['calculateRepaymentAmount']
        expect(data).to include(
          'amount' => 2422.48,
          'errors' => nil
        )
      end

      it 'successfully returns the repayment amount (edge-case: 30 days)' do
        now = (Date.today + 30.days).to_date
        post '/graphql', params: { query: query(amount: 240000, repaying_on: now.to_s) }

        json = JSON.parse(response.body)
        data = json['data']['calculateRepaymentAmount']
        expect(data).to include(
          'amount' => 2497.85,
          'errors' => nil
        )
      end

      it 'fails because an invalid repayment date was provided (negative duration)' do

        now = (Date.today - 30.days).to_date
        post '/graphql', params: { query: query(amount: 240000, repaying_on: now.to_s) }
    
        json = JSON.parse(response.body)

        data = json['data']['calculateRepaymentAmount']

        expect(data).to include(
          'amount' => 0.0,
          'errors' => [
            {
              "message" => "repayment date is invalid"
            }   
          ]
        )
      end


      it 'fails because an invalid repayment date was provided (duration greater than 30)' do

        now = (Date.today + 60.days).to_date
        post '/graphql', params: { query: query(amount: 240000, repaying_on: now.to_s) }
    
        json = JSON.parse(response.body)

        data = json['data']['calculateRepaymentAmount']

        expect(data).to include(
          'amount' => 0.0,
          'errors' => [
            {
              "message" => "repayment date is invalid"
            }   
          ]
        )

      end

      it 'fails because an invalid repayment date was provided (edge case: 31 days)' do

        now = (Date.today + 31.days).to_date
        post '/graphql', params: { query: query(amount: 240000, repaying_on: now.to_s) }
    
        json = JSON.parse(response.body)

        data = json['data']['calculateRepaymentAmount']

        expect(data).to include(
          'amount' => 0.0,
          'errors' => [
            {
              "message" => "repayment date is invalid"
            }   
          ]
        )
      end
    end
    
    def query(amount:, repaying_on:)
      <<~GQL
      query {
        calculateRepaymentAmount(amount: #{amount}, repayingOn: "#{repaying_on}") {
        amount
        errors {
            message
        }
        }
      }
      GQL
    end 
  end
end
