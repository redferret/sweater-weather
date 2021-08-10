class BookSearchSerializer < ActiveModel::Serializer
  type :books
  attributes :id, :destination, :forecast, :total_books_found, :books
end
