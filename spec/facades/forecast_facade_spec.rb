require 'rails_helper'

RSpec.describe ForecastFacade do
  VCR.use_cassette('onecall_forecast', record: :new_episodes) do
    describe 'class method,' do
      context '::onecall_forecast' do
        it 'returns a Forecast poro' do
          forecast = ForecastFacade.onecall_forecast('Denver,Co')

          expect(forecast).to be_a Forecast
            
          expect(forecast.current_weather).to have_key(:datetime)
          expect(forecast.current_weather).to have_key(:sunrise)
          expect(forecast.current_weather).to have_key(:sunset)
          expect(forecast.current_weather).to have_key(:temperature)
          expect(forecast.current_weather).to have_key(:feels_like)
          expect(forecast.current_weather).to have_key(:humidity)
          expect(forecast.current_weather).to have_key(:uvi)
          expect(forecast.current_weather).to have_key(:visibility)
          expect(forecast.current_weather).to have_key(:conditions)
          expect(forecast.current_weather).to have_key(:icon)

          expect(forecast.daily_weather.length).to eq 5
          
          first_day = forecast.daily_weather.first

          expect(first_day).to have_key(:date)
          expect(first_day).to have_key(:sunrise)
          expect(first_day).to have_key(:sunset)
          expect(first_day).to have_key(:max_temp)
          expect(first_day).to have_key(:min_temp)
          expect(first_day).to have_key(:conditions)
          expect(first_day).to have_key(:icon)

          expect(forecast.hourly_weather.length).to eq 8  

          first_hour = forecast.hourly_weather.first

          expect(first_hour).to have_key(:time)
          expect(first_hour).to have_key(:temperature)
          expect(first_hour).to have_key(:conditions)
          expect(first_hour).to have_key(:icon)
        end
      end
    end
  end
end
