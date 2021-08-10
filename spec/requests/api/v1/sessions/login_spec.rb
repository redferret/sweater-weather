require 'rails_helper'

RSpec.describe 'Login endpoint' do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:valid_params) { { email: 'testuser@gmail.com', password: 'password' } }

  before :all do
    User.destroy_all
    @user = create(:user, email: 'testuser@gmail.com', password: 'password')
  end

  describe 'POST /api/v1/sessions' do
    context 'with a valid request' do
      before {
        post '/api/v1/sessions', params: valid_params, headers: headers
      }

      it 'returns with status 200' do
        expect(response).to have_http_status 200
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

    context 'user not found' do
      before {
        request_body = { email: 'noone@islonely.com', password: 'password' }
        post '/api/v1/sessions', params: request_body, headers: headers
      }

      it 'returns with status 401 :unauthorized' do
        expect(response).to have_http_status 401
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Not Authorized'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ["Incorrect Email or Password"]
      end
    end

    context 'Incorrect password' do
      before {
        request_body = { email: 'testuser@gmail.com', password: 'awiuelf' }
        post '/api/v1/sessions', params: request_body, headers: headers
      }

      it 'returns with status 401 :unauthorized' do
        expect(response).to have_http_status 401
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Not Authorized'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ["Incorrect Email or Password"]
      end
    end

    context 'missing email field' do
      before {
        request_body = { password: 'password' }
        post '/api/v1/sessions', params: request_body, headers: headers
      }

      it 'returns with status 400 :bad_request' do
        expect(response).to have_http_status 400
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Missing field'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ["Email can't be blank"]
      end
    end

    context 'missing password field' do
      before {
        request_body = { email: 'email@mail.com' }
        post '/api/v1/sessions', params: request_body, headers: headers
      }

      it 'returns with status 400 :bad_request' do
        expect(response).to have_http_status 400
      end

      it 'contains the expected error message' do
        json = Oj.load(response.body, symbol_keys: true)
        expect(json).to have_key(:error)
        expect(json[:error]).to eq 'Missing field'
        expect(json).to have_key(:messages)
        expect(json[:messages]).to eq ["Password can't be blank"]
      end
    end

    context 'incorrect request type not being JSON' do
      before {
        request_body = { email: Faker::Internet.email, password: 'password' }
        post '/api/v1/sessions', params: request_body, headers: { HTTP_ACCEPT: 'text/plain' }
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
        post '/api/v1/sessions?email=test&password=test', headers: headers
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
