class Api::V1::BackgroundsController < ApplicationController
  def show
    if params[:location].present? && !params[:location].empty?
      background = BackgroundFacade.search_backgrounds(params[:location])
      render json: background, serializer: BackgroundSerializer, status: :ok
    else
      render json: {}, status: :not_found
    end
  end
end
