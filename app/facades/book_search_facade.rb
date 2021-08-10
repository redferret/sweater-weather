class BookSearchFacade
  def self.search_books(query, quantity)
    searched_books = OpenLibrary::API::ApiEndpoints.search_books(query, quantity)

    geo_location = Geocoding::V1::ApiEndpoints.geo_address(query)
    latLng = geo_location[:results].first[:locations].first[:latLng]

    onecall_result = OpenWeather::V2_5::ApiEndpoints.onecall(latLng[:lat], latLng[:lng])

    forecast = {
      temperature: "#{onecall_result[:current][:temp].to_f} F",
      summary: onecall_result[:current][:weather].first[:description]
    }

    books = searched_books[:docs].map do |doc|
      {
        title: doc[:title],
        isbn: doc[:isbn],
        publisher: doc[:publisher]
      }
    end

    BookSearch.new({
                     destination: query,
                     total_books_found: searched_books[:numFound],
                     forecast: forecast,
                     books: books
                   })
  end
end
