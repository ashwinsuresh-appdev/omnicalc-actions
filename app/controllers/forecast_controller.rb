require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather
    @lat = params.fetch("user_latitude").strip
    @lng = params.fetch("user_longitude").strip
    key = "9ecca62ca6194d59a6f8cb5995195d23"

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/" + key + "/" + @lat +"," + @lng
    parsed_results = JSON.parse(open(url).read)

    @current_temperature = parsed_results.dig("currently", "temperature")

    @current_summary = parsed_results.dig("currently", "summary")

    @summary_of_next_sixty_minutes = parsed_results.dig("minutely", "summary")

    @summary_of_next_several_hours = parsed_results.dig("hourly", "summary")

    @summary_of_next_several_days = parsed_results.dig("daily", "summary")

    render("forecast_templates/coords_to_weather.html.erb")
  end

  def coords_to_weather_form
    render("forecast_templates/coords_to_weather_form.html.erb")
  end
  
end
