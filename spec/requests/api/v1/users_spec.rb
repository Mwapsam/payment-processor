require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do

    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'users found' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              phone_number: { type: :string },
              role: { type: :string },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: [ 'id', 'phone_number', 'role', 'created_at', 'updated_at' ]
          }

        before do
          create_list(:user, 2)
        end

        run_test!
      end

      response '404', 'users not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
