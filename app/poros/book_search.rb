class BookSearch
  alias read_attribute_for_serialization send
  attr_reader :id,
              :forecast,
              :destination,
              :total_books_found,
              :books

  def initialize(attrs)
    @id = :null
    @forecast = attrs[:forecast]
    @destination = attrs[:destination]
    @total_books_found = attrs[:total_books_found]
    @books = attrs[:books]
  end

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end
end
