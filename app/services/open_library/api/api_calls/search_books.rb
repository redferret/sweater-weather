module SearchBooks
  def search_books(query, quantity)
    request :get, search_books_endpoint, params: {
      q: query,
      limit: quantity
    }
  end
end
