module RouteFinder
  def route_finder(from, to)
    request :get, route_finder_endpoint, params: {
      from: from,
      to: to
    }
  end
end
