require 'rails_helper'

RSpec.describe BookSearch do
  describe 'instance,' do
    before :all do
      @book_search = BookSearch.new({
        destination: 'denver,co',
        forecast: {},
        total_books_found: 122,
        books: []
      })
    end

    it 'exists' do
      expect(@book_search).to be_a BookSearch
      expect(BookSearch.model_name).to eq 'BookSearch'
    end

    it 'has an id and type' do
      expect(@book_search).to have_attributes(id: :null)
    end

    describe 'attributes,' do
      it 'has a destination' do
        expect(@book_search).to have_attributes(destination: 'denver,co')
      end

      it 'has a forecast' do
        expect(@book_search).to have_attributes(forecast: {})
      end

      it 'has total number of books found' do
        expect(@book_search).to have_attributes(total_books_found: 122)
      end

      it 'has a list of books' do
        expect(@book_search).to have_attributes(books: [])
      end
    end
  end
end
