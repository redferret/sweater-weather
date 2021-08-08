Dir[Rails.root.join('app/services/open_weather/2.5/api_calls/*.rb')].sort.each { |api_call| require api_call }

class OpenWeather::2.5::ApiEndpoints < OpenWeather::2.5::Client
  # API call modules
end
