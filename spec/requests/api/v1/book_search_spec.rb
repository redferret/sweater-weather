require 'rails_helper'

RSpec.describe 'Book Search endpoint' do
  VCR.use_cassette('onecall', record: :new_episodes) do
    VCR.use_cassette('geo_address', record: :new_episodes) do
      VCR.use_cassette('open_library', record: :new_episodes) do
        describe 'GET /api/v1/book-search?' do
          context 'with valid query params' do
            before :each do
              get '/api/v1/book-search?location=denver,co&quantity=5'
            end

            it 'returns status 200' do
              expect(response).to have_http_status 200
            end
            
            it 'returns expected data' do
              json = Oj.load(response.body, symbol_keys: true)

              expect(json).to have_key(:data)

              data = json[:data]

              expect(data).to have_key(:id)
              expect(data).to have_key(:type)
              expect(data).to have_key(:attributes)

              attributes = data[:attributes]

              expect(attributes).to have_key(:destination)
              expect(attributes).to have_key(:forecast)
              expect(attributes).to have_key(:total_books_found)
              expect(attributes).to have_key(:books)

              forecast = attributes[:forecast]

              expect(forecast).to be_a Hash
              expect(forecast).to have_key(:summary)
              expect(forecast).to have_key(:temperature)

              books = attributes[:books]

              expect(books).to be_an Array
              
              first_book = books.first

              expect(first_book).to have_key(:isbn)
              expect(first_book[:isbn).to be_an Array
              expect(first_book).to have_key(:title)
              expect(first_book).to have_key(:publisher)
              expect(first_book[:publisher).to be_an Array
            end
          end

          context 'with empty location' do
            it 'returns status of 404' do
              get '/api/v1/book-search?location&quantity=5'

              expect(response).to have_http_status 404
            end
          end

          context 'when quantity is 0 or negative' do
            it 'returns status of 400' do
              get '/api/v1/book-search?location=denver,co&quantity=0'
              expect(response).to have_http_status 400

              get '/api/v1/book-search?location=denver,co&quantity=-6'
              expect(response).to have_http_status 400
            end
          end
        end
      end
    end
  end
end
