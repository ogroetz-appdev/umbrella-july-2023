require "http"

p "Where are you?"

location = gets.chomp.gsub(" ", "%20")
p location

gmaps_api_key = ENV.fetch("GMAPS_KEY")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmaps_api_key}"
p gmaps_url

resp = HTTP.get(gmaps_url)

require "json"

parsed_response = JSON.parse(resp)
p parsed_response

results = parsed_response.fetch("results")
first_result = results.at(0)
geo = first_result.fetch("geometry")
loc = geo.fetch("location")
latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/#{latitude},#{longitude}"

# # Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

require "json"

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."
