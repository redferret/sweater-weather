class Api::V1::ForecastsController < ApplicationController
  def show
    if params[:location].present? && !params[:location].empty?
      forecast = ForecastFacade.onecall_forecast(params[:location])
      render json: forecast, serializer: ForecastSerializer, status: :ok
    else
      render json: {}, status: :not_found
    end
  end
end
