require 'rails_helper'

RSpec.describe BookSearch do
  let(:forecast) {
    {
      summary: "Cloudy with a chance of meatballs",
      temperature: "83 F"
    }
  }

  let(:books) {
    [
      {
        isbn: [
          "0762507845",
          "9780762507849"
        ],
        title: "Denver, Co",
        publisher: [
          "Universal Map Enterprises"
        ]
      }
    ]
  }

  describe 'instance,' do
    before :all do
      @book_search = BookSearch.new({
        destination: 'denver,co',
        forecast: forecast,
        total_books_found: 122,
        books: books
      })
    end

    it 'exists' do
      expect(@book_search).to be_a BookSearch
    end

    it 'has an id and type' do
      expect(@book_search).to have_attributes(id: :null, type: :books)
    end

    describe 'attributes,' do
      it 'has a destination' do
        expect(@book_search).to have_attributes(destination: 'denver,co')
      end

      it 'has a forecast' do
        expect(@book_search).to have_attributes(forecast: forecast)
      end

      it 'has total number of books found' do
        expect(@book_search).to have_attributes(total_books_found: 122)
      end

      it 'has a list of books' do
        expect(@book_search).to have_attributes(books: books)
      end
    end
  end
end
