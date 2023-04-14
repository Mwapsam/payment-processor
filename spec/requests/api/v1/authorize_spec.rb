require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'API', type: :request do
  path '/api/v1/payments' do
    post 'Initiate a payment' do
      tags 'Payments'
      consumes 'application/json'
      parameter name: :payment_request, in: :body, schema: {
        type: :object,
        properties: {
          amount: { type: :string },
          currency: { type: :string },
          external_id: { type: :string },
          payer: {
            type: :object,
            properties: {
              party_id_type: { type: :string },
              party_id: { type: :string }
            }
          },
          payer_message: { type: :string },
          payee_note: { type: :string }
        },
        required: ['amount', 'currency', 'external_id', 'payer', 'payer_message', 'payee_note']
      }
      produces 'application/json'
      response '200', 'payment initiated' do
        schema type: :object,
          properties: {
            reference_id: { type: :string }
          },
          required: ['reference_id']

        let(:payment_request) { { amount: '5000', currency: 'EUR', external_id: '12345', payer: { party_id_type: 'MSISDN', party_id: '0780123456' }, payer_message: 'test message', payee_note: 'test note' } }
        run_test!
      end
    end
  end
end
