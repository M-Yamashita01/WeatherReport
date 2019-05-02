require "json"
require "open-uri"

API_KEY = "xxxxx"
URL = "http://api.openweathermap.org/data/2.5/forecast"

response = open(URL + "?q=Tokyo,jp&APPID=#{API_KEY}")
puts JSON.pretty_generate(JSON.parse(response.read))
