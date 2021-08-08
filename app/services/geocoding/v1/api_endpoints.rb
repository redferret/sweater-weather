Dir[Rails.root.join('app/services/geocoding/v1/api_calls/*.rb')].sort.each { |api_call| require api_call }

class Geocoding::V1::ApiEndpoints < Geocoding::V1::Client
  # API call modules
end
