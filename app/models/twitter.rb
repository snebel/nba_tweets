require 'oauth'
require 'json'

class Twitter
  def initialize
    @consumer_key = OAuth::Consumer.new(
    	"3Ft58U1DWj5Rzy31mZ7hQ",
    	"tz6xjaYvhrRNZlPV2xBH7KJfqqf4v7tEef9oexj7I")
    @access_token = OAuth::Token.new(
    	"103690150-9TzmzmL8XQcPp8FBbvZeTybWXovCcgwQnmwenMwv",
    	"R8lnWa3a9Eq563ZKUGfH2GoD965FgJUuA2Z2R6I")    
  end

  def connect(baseurl, path)
	address = URI("#{baseurl}#{path}")
	request = Net::HTTP::Get.new address.request_uri
	http          = Net::HTTP.new address.host, address.port
	http.use_ssl  = true
	request.oauth! http, @consumer_key, @access_token
	http.start
	response = http.request request
  end

  def get_tweets(person)
  	baseurl = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
	path = "screen_name=#{person}&count=3&include_rts=1&exclude_replies=true"

	response = connect(baseurl, path)
	show_tweets(response.body)
  end

  def show_tweets(response)
  	tweets = JSON.parse(response)
	puts
	tweets.each do |tweet|
	  tweet["user"]["name"] + "\n" +
	  tweet["created_at"] + "\n" +
	  tweet["text"] + "\n" +
	  "media: #{tweet["entities"]["urls"][0]}" 
	end
  end

  def display_tweets(players)
 	players.each do |player|
	  get_tweets(player)
	end
  end

end
