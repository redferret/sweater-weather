require 'rails_helper'

RSpec.describe 'Registration endpoint' do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:valid_params) { { email: Faker::Internet.email, password: 'password', password_confirmation: 'password'} }

  describe 'POST /api/v1/user' do
    context 'with a valid request' do
      before {
        post '/api/v1/users', params: valid_params, headers: headers
      }

      it 'returns with status 201' do
        expect(response).to have_http_status 201
      end

      it 'contains the expected data' do
        json = Oj.load(response.body, symbol_keys: true)

        expect(json).to have_key(:data)

        data = json[:data]

        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        attrs = data[:attributes]

        expect(attrs).to have_key(:email)
        expect(attrs).to have_key(:api_key)
      end
    end

    context 'when passwords do not match' do
      before {
        request_body = { email: Faker::Internet.email, password: 'password', password_confirmation: 'passwesd'}
        post '/api/v1/users', params: request_body, headers: headers
      }

      it 'returns with status 400 :bad_request' do
        expect(response).to have_http_status 400
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Could not create User'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ["Password confirmation doesn't match Password"]
      end
    end

    context 'missing email field' do
      before {
        request_body = { password: 'password', password_confirmation: 'password'}
        post '/api/v1/users', params: request_body, headers: headers
      }

      it 'returns with status 400 :bad_request' do
        expect(response).to have_http_status 400
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Could not create User'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ["Email can't be blank", "Email is invalid"]
      end
    end

    context 'email already taken' do
      before {
        request_body = { email: 'test@test.com', password: 'password', password_confirmation: 'password'}
        User.destroy_all
        create(:user, email: 'test@test.com')
        post '/api/v1/users', params: request_body, headers: headers
      }

      it 'returns with status 400 :bad_request' do
        expect(response).to have_http_status 400
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Could not create User'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ["Email has already been taken"]
      end
    end

    context 'incorrect request type not being JSON' do
      before {
        request_body = { email: Faker::Internet.email, password: 'password', password_confirmation: 'password'}
        post '/api/v1/users', params: request_body, headers: { HTTP_ACCEPT: 'text/plain' }
      }

      it 'returns with status 406 :not_acceptable' do
        expect(response).to have_http_status 406
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Incorrect Content Type'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ['Must use application/json']
      end
    end

    context 'incorrect request using query params' do
      before {
        post '/api/v1/users?email=test&password=test', headers: headers
      }

      it 'returns with status 406 :not_acceptable' do
        expect(response).to have_http_status 406
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Query Parameters Detected'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ['Must use application/json in the request body']
      end
    end
  end
end
