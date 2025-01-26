# Write your solution here!
require "http"
require "json"
require "dotenv/load"

puts "Hi! Where are you located?"
# user_loc = gets.chomp # comment in/out to facilitate code testing
user_loc = "JP Morgan Chase Tower" # hardcoded location for development
puts "Checking the weather at #{user_loc}..."

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_loc}&key=#{ENV.fetch("GMAPS_KEY")}"

# pull and store info from Google Maps API
gmaps_hash = JSON.parse(HTTP.get(gmaps_url))

# retrieve latitude and longitude information from gmaps_hash
gmaps_coordinates = gmaps_hash.fetch("results")[0].fetch("geometry").fetch("location")
lat = gmaps_coordinates.fetch("lat")
lng = gmaps_coordinates.fetch("lng")
puts "Your coordinates are: lat = #{lat.round(3)}; lng = #{lng.round(3)}. Analyzing..."


# pull and store weather info from Pirate Weather
pirateweather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{lat},#{lng}"
pirateweather_hash = JSON.parse(HTTP.get(pirateweather_url))
current_weather_hash = pirateweather_hash.fetch("currently")

# current weather info
current_weather_summary = current_weather_hash.fetch("summary")
current_temp = current_weather_hash.fetch("temperature")

puts "It is currently #{current_temp}\u00B0F."
puts "Current conditions: #{current_weather_summary}"

# hourly forecast
hourly_fcst_hash = pirateweather_hash.fetch("hourly").fetch("data")
next_twelve_hash = hourly_fcst_hash[1..12]

need_umbrella = false
next_hour = 0

puts "Next 12-hour precipation likelihood:"
next_twelve_hash.each do |hour|
  next_hour = next_hour + 1
  prob_rain = hour.fetch("precipProbability")
  if prob_rain >= 0.1
    need_umbrella = true
  end
  puts "   - In #{next_hour} hour(s), #{(prob_rain*100).round(0)}% chance"
end

if need_umbrella
  puts "You might want to carry an umbrella!"
end
