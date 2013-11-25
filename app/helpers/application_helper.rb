module ApplicationHelper
  def connect(baseurl, path)
	address = URI("#{baseurl}#{path}")
	request = Net::HTTP::Get.new address.request_uri
	http          = Net::HTTP.new address.host, address.port
	http.use_ssl  = true
	#request.oauth! http, @consumer_key, @access_token
	request.oauth! http, OAuth::Consumer.new("3Ft58U1DWj5Rzy31mZ7hQ",
		"tz6xjaYvhrRNZlPV2xBH7KJfqqf4v7tEef9oexj7I"),
		OAuth::Token.new("103690150-9TzmzmL8XQcPp8FBbvZeTybWXovCcgwQnmwenMwv",
    	"R8lnWa3a9Eq563ZKUGfH2GoD965FgJUuA2Z2R6I")  
	http.start
	resp = http.request request

  end

  def get_tweet_html(id)
  	address = URI("https://api.twitter.com/1/statuses/oembed.json?id=#{id}&align=center&maxwidth=500")
	request = Net::HTTP::Get.new address.request_uri
	http          = Net::HTTP.new address.host, address.port
	http.use_ssl  = true
	http.start
	resp = http.request request
	JSON.parse(resp.body)["html"]
  end

  def get_tweet_ids(person)
  	baseurl = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
	path = "screen_name=#{person}&count=3&include_rts=1&exclude_replies=true"

	response = connect(baseurl, path)
	tweets = JSON.parse(response.body)

	ids = []
	tweets.each do |tweet|
	  ids << tweet["id"]	
	end
	return ids
  end


  def display_tweets(players)
  	team_tweets = []
 	players.each do |player|
	  team_tweets << get_tweet_ids(player)
	end
	return show_tweets(team_tweets)
  end

  def show_tweets(team_tweets)
  	htmls = []
  	team_tweets.each do |player|
  	  player.each do |id|
  	  	htmls << get_tweet_html(id)
  	  end
  	end
  	return htmls
  end

end
