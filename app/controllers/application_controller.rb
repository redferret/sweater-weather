class ApplicationController < ActionController::API
  def request_has_valid_body
    request.query_string.empty?
  end

  def invalid_request_errors
    { error: 'Query Parameters Detected', messages: ['Must use application/json in the request body'] }
  end

  def request_has_valid_accept_content
    request.headers[:HTTP_ACCEPT] && request.headers[:HTTP_ACCEPT] == 'application/json'
  end

  def invalid_content_type_errors
    { error: 'Incorrect Content Type', messages: ['Must use application/json'] }
  end
end
