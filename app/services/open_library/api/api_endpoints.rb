Dir[Rails.root.join('app/services/open_library/api/api_calls/*.rb')].sort.each { |api_call| require api_call }

class OpenLibrary::API::ApiEndpoints < OpenLibrary::API::Client
  # API call modules
  extend SearchBooks
end
