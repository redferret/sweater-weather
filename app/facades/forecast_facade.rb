class ForecastFacade
  def self.onecall_forecast(location)
    geo_location = Geocoding::V1::ApiEndpoints.geo_address(location)
    latLng = geo_location[:results].first[:locations].first[:latLng]
    forecast = OpenWeather::V2_5::ApiEndpoints.onecall(latLng[:lat], latLng[:lng])
    current_weather_timezone = forecast[:timezone]
    current = forecast[:current]

    current_weather = {
      datetime: Time.at(current[:dt].to_i).in_time_zone(current_weather_timezone).strftime("%m/%d/%y %I:%M %p"),
      sunrise: Time.at(current[:sunrise].to_i).in_time_zone(current_weather_timezone).strftime("%m/%d/%y %I:%M %p"),
      sunset: Time.at(current[:sunset].to_i).in_time_zone(current_weather_timezone).strftime("%m/%d/%y %I:%M %p"),
      temperature: current[:temp].to_f,
      feels_like: current[:feels_like].to_f,
      humidity: current[:humidity].to_i,
      uvi: current[:uvi].to_i,
      visibility: current[:visibility].to_i,
      conditions: current[:weather].first[:description],
      icon: current[:weather].first[:icon]
    }

    daily = forecast[:daily][0..4].map do |day|
      {
        date: Time.at(day[:dt].to_i).in_time_zone(current_weather_timezone).strftime("%m/%d/%y %I:%M %p"),
        sunrise: Time.at(day[:sunrise].to_i).in_time_zone(current_weather_timezone).strftime("%m/%d/%y %I:%M %p"),
        sunset: Time.at(day[:sunset].to_i).in_time_zone(current_weather_timezone).strftime("%m/%d/%y %I:%M %p"),
        max_temp: day[:temp][:max].to_f,
        min_temp: day[:temp][:min].to_f,
        conditions: day[:weather].first[:description],
        icon: day[:weather].first[:icon]
      }
    end

    hourly = forecast[:hourly][0..7].map do |hour|
      {
        time: Time.at(hour[:dt].to_i).in_time_zone(current_weather_timezone).strftime("%m/%d/%y %I:%M %p"),
        temperature: hour[:temp].to_f,
        conditions: hour[:weather].first[:description],
        icon: hour[:weather].first[:icon]
      }
    end

    Forecast.new({
      current_weather: current_weather,
      daily_weather: daily,
      hourly_weather: hourly
    })
  end
end