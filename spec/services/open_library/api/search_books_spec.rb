require 'rails_helper'

RSpec.describe OpenLibrary::API::ApiEndpoints, :vcr do
  VCR.use_cassette('search_books', record: :new_episodes) do
    describe 'search_books' do
      it 'returns expected data when successful' do
        query = 'denver,co'
        response = OpenLibrary::API::ApiEndpoints.search_books(query, 5)

        expect(response).to have_key(:docs)
        expect(response).to have_key(:numFound)

        doc = response[:docs].first

        expect(doc).to have_key(:isbn)
        expect(doc).to have_key(:publisher)
        expect(doc).to have_key(:title)
      end
    end
  end
end
