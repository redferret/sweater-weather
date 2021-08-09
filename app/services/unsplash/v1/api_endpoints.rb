Dir[Rails.root.join('app/services/unsplash/v1/api_calls/*.rb')].sort.each { |api_call| require api_call }

class Unsplash::V1::ApiEndpoints < Unsplash::V1::Client
  # API call modules
  extend SearchPhotos
end
