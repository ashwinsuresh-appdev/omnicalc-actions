require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)
    map_key = "AIzaSyBr-0XDfztIIUGyPRfa1D5KfPvURvAk2e4"
    weather_key = "9ecca62ca6194d59a6f8cb5995195d23"

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================

    map_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + sanitized_street_address + "&key=" + map_key
    parsed_data = JSON.parse(open(map_url).read)
    @lat = parsed_data.dig("results", 0, "geometry", "location", "lat").to_s
    @lng = parsed_data.dig("results", 0, "geometry", "location", "lng").to_s
    
    weather_url = "https://api.darksky.net/forecast/" + weather_key + "/" + @lat +"," + @lng
    parsed_results = JSON.parse(open(weather_url).read)

    @current_temperature = parsed_results.dig("currently", "temperature")

    @current_summary = parsed_results.dig("currently", "summary")

    @summary_of_next_sixty_minutes = parsed_results.dig("minutely", "summary")

    @summary_of_next_several_hours = parsed_results.dig("hourly", "summary")

    @summary_of_next_several_days = parsed_results.dig("daily", "summary")

    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end
