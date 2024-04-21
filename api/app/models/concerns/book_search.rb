require 'httparty'

class BookSearch

  include ::HTTParty
   base_uri 'https://www.googleapis.com/books/v1/volumes?'
    def self.advanced_search(query)

      response = get("", query: {
         "q": query,
        "intitle": query,
        "filter": "full",
        #"printType": "full",
        "projection": "full",
        "orderBy": "relevance",
        "maxResults": 20,
        "key": GOOGLE_BOOKS_API_KEY,
      })
    # puts query
    # response = get('',  {
    #   #"intitle": "biblia",
    #   "q": query,
    #   "filter": "full",
    #   "printType": "full",
    #   "projection": "full" ,
    #   "orderBy": "relevance",
    #   "maxResults": 20,
    #   key: GOOGLE_BOOKS_API_KEY,
    # })
    JSON.parse(response.body)
  end
end