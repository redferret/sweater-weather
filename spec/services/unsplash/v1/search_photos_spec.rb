require 'rails_helper'

RSpec.describe Unsplash::V1::ApiEndpoints, :vcr do
  describe 'search_photos' do
    it 'returns expected data when successful' do
      response = Unsplash::V1::ApiEndpoints.search_photos('denver,co')

      expect(response).to have_key(:results)

      first_result = response[:results].first
      
      expect(first_result).to have_key(:urls)
      expect(first_result).to have_key(:user)
      expect(first_result[:urls]).to have_key(:regular)
      expect(first_result[:user]).to have_key(:portfolio_url)
      expect(first_result[:user]).to have_key(:username)
    end
  end
end
