require 'rails_helper'
module Queries
    RSpec.describe CalculateRepaymentAmount, type: :request do
        describe '.resolve' do
            it 'successfully returns the repayment amount' do

            post '/graphql', params: { query: query(amount: 24, repaying_on: "2021-06-17") }

            json = JSON.parse(response.body)
            data = json['data']['calculateRepaymentAmount']

            expect(data).to include(
                'amount' => be_present,
                'errors' => nil
            )
            end

            it 'fails because an invalid repayment date was provided' do

                post '/graphql', params: { query: query(amount: 24, repaying_on: "2020-09-09") }
    
                json = JSON.parse(response.body)
                puts json
                # data = json['data']['author']
    
                # expect(data).to include(
                #     'id'          =&gt; be_present,
                #     'firstName'   =&gt; 'Lee',
                #     'lastName'    =&gt; 'Child',
                #     'dateOfBirth' =&gt; '1954-10-29',
                #     'books'       =&gt; [{ 'id' =&gt; book.id.to_s }]
                # )
                end            
        end
    
        def query(amount:, repaying_on:)
            <<~GQL
            query {
                calculateRepaymentAmount(amount: #{amount}, repayingOn: "#{repaying_on}") {
                amount
                errors
                }
            }
            GQL
        end 
    end
end
