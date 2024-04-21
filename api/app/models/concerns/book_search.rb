require 'httparty'

class BookSearch

  include ::HTTParty
  base_uri 'https://www.googleapis.com/books/v1/volumes'
  def self.advanced_search(query)
    options = {
      query: {
        q: query,
        key: GOOGLE_BOOKS_API_KEY,
        maxResults: 10,
        orderBy: 'relevance'
      }
    }
    response = get('', options)
    JSON.parse(response.body)
  end
end