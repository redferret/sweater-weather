require 'rails_helper'

RSpec.describe 'Forecast Request' do
  describe 'GET /api/v1/forecast' do
    context 'when valid query param given' do
      before :each do
        get '/api/v1/forecast?location=denver,co'
      end

      it 'returns with status 200' do
        expect(response).to have_http_status 200
      end

      it 'request body has expected json format' do
        json = Oj.load(response.body, symbol_keys: true)

        expect(json).to have_key(:data)
        data = json[:data]

        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data[:type]).to eq('forecast')
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]

        expect(attributes).to have_key(:current_weather)
        expect(attributes).to have_key(:daily_weather)
        expect(attributes).to have_key(:hourly_weather)
      end
    end

    context 'when empty query param is given' do
      it 'returns status 404' do
        get '/api/v1/forecast'
        expect(response).to have_http_status 404
      end
    end
  end
end
