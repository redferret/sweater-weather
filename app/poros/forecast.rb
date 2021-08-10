class Forecast
  alias read_attribute_for_serialization send
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id

  def initialize(attrs)
    @id = :null
    @current_weather = attrs[:current_weather]
    @daily_weather = attrs[:daily_weather]
    @hourly_weather = attrs[:hourly_weather]
  end

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end
end
