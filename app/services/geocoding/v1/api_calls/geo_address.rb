module GeoAddress
  def geo_address(location)
    request :get, geo_address_endpoint, params: {
      location: location
    }
  end
end
