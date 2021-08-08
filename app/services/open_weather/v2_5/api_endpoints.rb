Dir[Rails.root.join('app/services/open_weather/v2_5/api_calls/*.rb')].sort.each { |api_call| require api_call }

class OpenWeather::V2_5::ApiEndpoints < OpenWeather::V2_5::Client
  # API call modules
  extend Onecall
end
