require 'rails_helper'

RSpec.describe BookSearchFacade, :vcr do
  VCR.use_cassette('book_search', record: :new_episodes) do
    VCR.use_cassette('geo_address', record: :new_episodes) do
      VCR.use_cassette('onecall', record: :new_episodes) do
        describe 'class method,' do
          context '::search_books' do
            it 'returns a BookSearch poro instance' do
              book_search = BookSearchFacade.search_books('denver,co', 5)

              expect(book_search).to be_a BookSearch
              expect(book_search.destination).to eq 'denver,co'

              expect(book_search.forecast).to have_key(:summary)
              expect(book_search.forecast).to have_key(:temperature)
              expect(book_search.total_books_found).to eq 35_991
              expect(book_search.books).to be_an Array
              expect(book_search.books.length).to eq 5

              first_book = book_search.books.first

              expect(first_book).to have_key(:isbn)
              expect(first_book[:isbn]).to be_an Array
              expect(first_book).to have_key(:title)
              expect(first_book).to have_key(:publisher)
              expect(first_book[:publisher]).to be_an Array
            end
          end
        end
      end
    end
  end
end
