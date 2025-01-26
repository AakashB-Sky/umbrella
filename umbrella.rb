# Write your solution here!
require "http"
require "json"
require "dotenv/load"

pp "Hi! Where are you located?"
# user_loc = gets.chomp # comment in/out to facilitate code testing
user_loc = "151 N Michigan Ave Chicago, IL 60601" # hardcoded location for development
pp user_loc

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_loc}&key=#{ENV.fetch("GMAPS_KEY")}"

# pull and store info from Google Maps API
gmaps_hash = JSON.parse(HTTP.get(gmaps_url))

# retrieve latitude and longitude information from gmaps_hash
gmaps_coordinates = gmaps_hash.fetch("results")[0].fetch("geometry").fetch("location")
lat = gmaps_coordinates.fetch("lat")
lng = gmaps_coordinates.fetch("lng")

# pull and store weather info from Pirate Weather
pirateweather_url = "https://api.pirateweather.net/forecast/#{PIRATE_WEATHER_KEY}/#{lat},#{lng}"
pirateweather_hash = JSON.parse(HTTP.get(pirateweather_url))
pp pirateweather_hash
