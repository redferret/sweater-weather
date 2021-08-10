require 'rails_helper'

RSpec.describe 'Backgrounds Endpoint', :vcr do
  describe 'GET /api/v1/backgrounds' do
    context 'when valid query param given' do
      before :each do
        get '/api/v1/backgrounds?location=denver,co'
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
        expect(data[:type]).to eq('image')
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]

        expect(attributes).to have_key(:image)

        image = attributes[:image]

        expect(image).to have_key(:location)
        expect(image).to have_key(:image_url)
        expect(image).to have_key(:author)

        expect(image[:author]).to have_key(:portfolio_url)
        expect(image[:author]).to have_key(:username)
        expect(image[:author]).to have_key(:name)
      end
    end

    context 'when empty or missing query param is given' do
      it 'returns status 404' do
        get '/api/v1/backgrounds'
        expect(response).to have_http_status 404

        get '/api/v1/backgrounds?location'
        expect(response).to have_http_status 404
      end
    end
  end
end
