class Api::V1::Sessions::LoginController < ApplicationController
  def create
    render json: invalid_content_type_errors, status: :not_acceptable and return unless request_has_valid_accept_content
    render json: invalid_request_errors, status: :not_acceptable and return unless request_has_valid_body

    render json: { error: 'Missing field', messages: ["Email can't be blank"] }, status: :bad_request and return if params[:email].nil?
    render json: { error: 'Missing field', messages: ["Password can't be blank"] }, status: :bad_request and return if params[:password].nil?
    @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    render json: { error: 'Not Authorized', messages: ["Incorrect Email or Password"] }, status: :unauthorized and return unless @user

    render json: @user, status: :ok
  end
end
