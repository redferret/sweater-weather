require 'rails_helper'

RSpec.describe Geocoding::V1::ApiEndpoints, :vcr do
  VCR.use_cassette('address', record: :new_episodes) do
    describe 'geo_address' do
      it 'returns expected data when successful' do
        location = 'Denver,Co'
        json = Geocoding::V1::ApiEndpoints.geo_address(location)
        
        expect(json).to have_key(:results)
        
        results = json[:results].first

        expect(results).to have_key(:locations)

        location = results[:locations].first

        expect(location).to have_key(:latLng)

        latLng = location[:latLng]

        expect(latLng).to have_key(:lat)
        expect(latLng).to have_key(:lng)
      end
    end
  end
end
