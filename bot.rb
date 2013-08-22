require 'cinch'

require 'weatherboy'

weatherboy=Weatherboy.new("Toronto")
w = weatherboy.current

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#bitmakerlabs"]
    c.nick = "weatherbot"
  end

  on :message, "hello" do |m|
    m.reply "Hello, #{m.user.nick}"
  end

  on :message, "weather" do |m|
    m.reply "Hello, in order to get the weather say '!weather city' example '!weather toronto'on :message, /^!google (.+)/ do |m, query|"
  end

  on :message, /^!weather (.+)/ do |m, query|
  	weatherboy=Weatherboy.new(query)
  	w = weatherboy.current
  	m.reply "Hi there! The current weather in #{query} is #{w.weather}. It's about #{w.temp_f} degrees F."
  end


end

bot.start