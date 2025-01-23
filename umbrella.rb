# Write your solution here!
require "http"
require "dotenv/load"

pp "Hi! Where are you located?"
# user_loc = gets.chomp # comment in/out to facilitate code testing
user_loc = "151 N Michigan Ave Chicago, IL 60601" # hardcoded location for development
pp user_loc

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_loc}&key=#{ENV.fetch("GMAPS_KEY")}"

pp gmaps_url

pp HTTP.get(gmaps_url)
