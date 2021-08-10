require 'rails_helper'

RSpec.describe Forecast do
  describe 'instance,' do
    before :each do
      attrs = {
        current_weather: {},
        daily_weather: {},
        hourly_weather: {}
      }
      @forecast = Forecast.new(attrs)
    end

    it 'exists' do
      expect(@forecast).to be_a Forecast
      expect(Forecast.model_name).to eq 'Forecast'
    end

    it 'has expected attributes' do
      expect(@forecast.current_weather).to be_a Hash
      expect(@forecast.daily_weather).to be_a Hash
      expect(@forecast.hourly_weather).to be_a Hash
    end
  end

  describe 'class method,' do
    context '::model_name' do
      it 'returns the name of the model' do
        expect(Forecast.model_name).to eq 'Forecast'
      end
    end
  end
end
