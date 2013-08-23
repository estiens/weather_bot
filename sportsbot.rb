require 'cinch'
require 'espn'

client = ESPN::Client.new(api_key: 'p8d3ts2g97j52v8u6uqf4wsf')

# headlines = client.headlines(sport: @sport).headlines
# headlines.take(3).each {|x| puts "#{x.linkText}\n#{x.description}\n\n" if !x.nil?}

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#bitmaker"]
    c.nick = "sportsbot"
  end

  helpers do
    
    def sport
      @sport||="football"
    end
    def setSport(sport)
      @sport=sport
    end

  end

  on :message, /^!headlines/ do |m|
    headlines = client.headlines(sport: sport).headlines
    # currentcontent = headlines.take(3).each {|x| puts "#{x.linkText}\n#{x.description}\n\n" if !x.nil?}
    currentcontent = headlines.take(3).map {|x| "#{x.linkText}\n#{x.description}\n\n" if !x.nil?}
    currentcontent.each {|headline| m.reply "#{headline}\n" }  
      
  end

  on :message, /^!sport (.+)/ do |m, sport|
    setSport(sport)
    m.reply "Okay, checking the headlines for #{sport}"
  end

 

end

bot.start
  