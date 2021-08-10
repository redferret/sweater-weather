class Api::V1::Users::RegistrationController < ApplicationController
  def create
    render json: invalid_content_type_errors, status: :not_acceptable and return unless request_has_valid_accept_content
    render json: invalid_request_errors, status: :not_acceptable and return unless request_has_valid_body

    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: could_not_create_user_errors, status: :bad_request
    end
  end

  private

  def could_not_create_user_errors
    { error: 'Could not create User', messages: @user.errors.full_messages }
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
