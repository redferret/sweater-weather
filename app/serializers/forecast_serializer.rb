class ForecastSerializer < ActiveModel::Serializer
  type :forecast
  attributes :id, :current_weather, :daily_weather, :hourly_weather
end