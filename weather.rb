#require 'forecast_io'
#
#ForecastIO.api_key='5d7ea8421dcfbc2766c3960079c9bd21'
#
#forecast = ForecastIO.forecast(37.8267, -122.423)
#
#puts forecast

require 'weatherboy'

weatherboy=Weatherboy.new("Toronto")
w = weatherboy.current

puts "Hi there! I'm a weather bot. Please give me a location? For example 'weather toronto'"


puts ""

puts "Hi there! The current weather in Toronto is #{w.weather}. It's about #{w.temp_f} degrees F."