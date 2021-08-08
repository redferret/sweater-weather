module Onecall
  def onecall(lat, lon)
    response = request :get, onecall_endpoint, params: {
      lat: lat,
      lon: lon,
      units: 'imperial',
      exclude: 'minutely'
    }
  end
end
