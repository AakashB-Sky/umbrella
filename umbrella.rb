# Write your solution here!
require "http"
require "json"
require "dotenv/load"

pp "Hi! Where are you located?"
# user_loc = gets.chomp # comment in/out to facilitate code testing
user_loc = "JP Morgan Chase Tower" # hardcoded location for development
pp "Checking the weather at #{user_loc}..."

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_loc}&key=#{ENV.fetch("GMAPS_KEY")}"

# pull and store info from Google Maps API
gmaps_hash = JSON.parse(HTTP.get(gmaps_url))

# retrieve latitude and longitude information from gmaps_hash
gmaps_coordinates = gmaps_hash.fetch("results")[0].fetch("geometry").fetch("location")
lat = gmaps_coordinates.fetch("lat")
lng = gmaps_coordinates.fetch("lng")
pp "Your coordinates are: lat = #{lat.round(3)}; lng = #{lng.round(3)}. Analyzing..."


# pull and store weather info from Pirate Weather
pirateweather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{lat},#{lng}"
pirateweather_hash = JSON.parse(HTTP.get(pirateweather_url))
current_weather_hash = pirateweather_hash.fetch("currently")

# current weather info
current_weather_summary = current_weather_hash.fetch("summary")
current_temp = current_weather_hash.fetch("temperature")

pp "It is currently #{current_temp}\u00B0F."
pp "Current conditions: #{current_weather_summary}"
