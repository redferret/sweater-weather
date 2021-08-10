class Api::V1::SearchBooksController < ApplicationController
  def show
    render json: { error: 'quantity must be greater than 0' }, status: :bad_request and return if quantity_non_positive
    render json: {}, status: :not_found and return if location_is_empty_or_missing

    book_search = BookSearchFacade.search_books(params[:location], params[:quantity].to_i)

    render json: book_search, serializer: BookSearchSerializer, status: :ok
  end

  private
  
  def quantity_non_positive
    params[:quantity].nil? || params[:quantity].to_i < 1
  end

  def location_is_empty_or_missing
    params[:location].nil? || params[:location].empty?
  end
end