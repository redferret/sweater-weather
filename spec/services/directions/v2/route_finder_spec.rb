require 'rails_helper'

RSpec.describe Directions::V2::ApiEndpoints, :vcr do
  describe 'route_finder' do
    it 'returns expected data when successful' do
      from = 'denver,co'
      to = 'pueblo,co'
      response = Directions::V2::ApiEndpoints.route_finder(from, to)
      
      expect(response).to have_key(:route)
      expect(response[:route]).to have_key(:realTime)
      expect(response[:route]).to have_key(:locations)
      expect(response[:route][:locations]).to be_an Array
    end
  end
end
