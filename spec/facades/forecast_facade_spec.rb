require 'rails_helper'

RSpec.describe ForecastFacade do
  VCR.use_cassette('onecall_forecast', record: :new_episodes) do
    describe 'class method,' do
      context '::onecall_forecast' do
        it 'returns a Forecast poro' do
          forecast = ForecastFacade.onecall_forecast('Denver,Co')

          expect(forecast).to be_a Forecast
          
        end
      end
    end
  end
end
