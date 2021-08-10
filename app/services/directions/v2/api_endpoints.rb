Dir[Rails.root.join('app/services/directions/v2/api_calls/*.rb')].sort.each { |api_call| require api_call }

class Directions::V2::ApiEndpoints < Directions::V2::Client
  # API call modules
  extend RouteFinder
end
