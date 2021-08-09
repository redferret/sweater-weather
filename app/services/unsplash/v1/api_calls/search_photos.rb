module SearchPhotos
  def search_photos(query)
    request :get, search_photos_endpoint, params: {
      per_page: 1,
      query: query
    }
  end
end
