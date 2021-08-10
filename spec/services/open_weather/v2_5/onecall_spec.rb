require 'rails_helper'

RSpec.describe OpenWeather::V2_5::ApiEndpoints, :vcr do
  describe 'onecall' do
    it 'returns expected data when successful' do
      # Define endpoint parameters here
      lat = 39.738453
      lon = -104.984853
      response = OpenWeather::V2_5::ApiEndpoints.onecall(lat, lon)

      expect(response).to have_key(:current)
      expect(response).to have_key(:hourly)
      expect(response).to have_key(:daily)
      expect(response).not_to have_key(:minutely)

      current = response[:current]

      expect(current).to have_key(:dt)
      expect(current).to have_key(:sunrise)
      expect(current).to have_key(:sunset)
      expect(current).to have_key(:temp)
      expect(current).to have_key(:feels_like)
      expect(current).to have_key(:humidity)
      expect(current).to have_key(:uvi)
      expect(current).to have_key(:visibility)
      expect(current).to have_key(:weather)

      weather = current[:weather].first

      expect(weather).to have_key(:main)
      expect(weather).to have_key(:description)
      expect(weather).to have_key(:icon)

      daily = response[:daily].first

      expect(daily).to have_key(:dt)
      expect(daily).to have_key(:sunrise)
      expect(daily).to have_key(:sunset)
      expect(daily).to have_key(:temp)
      expect(daily).to have_key(:weather)

      daily_temp = daily[:temp]

      expect(daily_temp).to have_key(:max)
      expect(daily_temp).to have_key(:min)

      daily_weather = daily[:weather].first

      expect(daily_weather).to have_key(:description)
      expect(daily_weather).to have_key(:icon)

      hourly = response[:hourly].first

      expect(hourly).to have_key(:dt)
      expect(hourly).to have_key(:temp)
      expect(hourly).to have_key(:weather)

      hourly_weather = daily[:weather].first

      expect(hourly_weather).to have_key(:description)
      expect(hourly_weather).to have_key(:icon)
    end
  end
end
