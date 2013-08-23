require 'cinch'
require 'weatherboy'
require 'cgi'

#initials#



bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#bitmakerlabs"]
    c.nick = "weatherbot"
  end

  helpers do
    def location
      @location||="Toronto"
    end
    def setLocation(local)
      @location = local
    end
  end

  on :message, "weather" do |m|
    m.reply "Hello, in order to get the weather in #{CGI.unescape(location)} say '!currentweather. To change locations say '!location city'. To get help with other commands say !whelp."
  end

   on :message, "farenheit"  do |m|
    m.reply "I'm an American bot. I speak Farenheit."
  end

  on :message, "celsius"  do |m|
    m.reply "I'm an American bot. I speak Farenheit."
  end


  on :message, /^!currentweather/ do |m|
  	weatherboy=Weatherboy.new(location)
  	w = weatherboy.current
  	m.reply "Hi there! The current weather in #{CGI.unescape(location)} is #{w.weather}. It's about #{w.temp_f} degrees F."
  	@last_temp=w.temp_f
  end

  on :message, /^!forecast/ do |m|
  	weatherboy=Weatherboy.new(location)
  	f = weatherboy.forecasts
  	m.reply "Tomorrow it will be #{f[0].conditions} in #{location} with a high of #{f[0].high_f} and a low of #{f[0].low_f}. But I might be wrong!"
  end

  on :message, /^!whelp/ do |m|
    m.reply "I know the following commands !currentweather, !forecast, !location."
  end


  on :message, /^!radar/ do |m|
    weatherboy=Weatherboy.new(location)
    r = weatherboy.media
    m.reply "#{r[:radar].image_url}"
  end

	on :message, /^!location (.+)/ do |m, newlocal|
    newlocal = CGI.escape(newlocal)
    setLocation newlocal
		m.reply "Okay, now checking the weather in #{CGI.unescape(location)}"
	end

  on :message

end

bot.start
