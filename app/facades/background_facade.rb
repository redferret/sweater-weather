class BackgroundFacade
  def self.search_backgrounds(location)
    response = Unsplash::V1::ApiEndpoints.search_photos('denver,co')
    first_result = response[:results].first

    image = {
      location: location,
      image_url: first_result[:urls][:regular],
      author: {
        portfolio_url: first_result[:user][:portfolio_url],
        username: first_result[:user][:username],
        source: Unsplash::V1::ApiEndpoints.unsplash_api_endpoint,
        name: first_result[:user][:name]
      }
    }
    Background.new({image: image})
  end
end