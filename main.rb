# coding: utf-8
require "json"
require "faraday"
require "parseconfig"

CONFIG = ParseConfig.new("config")
API_KEY = CONFIG['api_key']
API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"

def search(term, location, limit=10)
  url = "#{API_HOST}#{SEARCH_PATH}"
  params = {
    term: term,
    location: location,
    limit: limit
  }

  con = Faraday.new() do |conn|
    conn.headers['Authorization'] = "Bearer #{API_KEY}"
    conn.use Faraday::Adapter::NetHttp
  end
  p JSON.parse con.get(url,params).body
end

p search("Ramen","Tokyo")
