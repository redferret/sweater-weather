require_relative 'endpoint_helpers'

class Unsplash::V1::Client
  extend EndpointHelpers

  def self.client(params)
    params[:client_id] = ENV['UNSPLASH_API_KEY']
    Faraday.new(
      url: unsplash_api_endpoint,
      params: params
    )
  end

  def self.request(method = :get, endpoint = nil, params: {})
    raise 'API endpoint must be defined' if endpoint.nil?

    connection = client(params)

    @response = connection.send(method, endpoint)

    return parse_json if response_successful?

    raise "Status: #{@response.status}, Response: #{@response.body}"
  end

  def self.parse_json
    Oj.load(@response.body, symbol_keys: true)
  end

  def self.response_successful?
    @response.status == 200
  end

  private_class_method :parse_json, :response_successful?
end
