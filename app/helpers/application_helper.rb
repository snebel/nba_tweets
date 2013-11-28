module ApplicationHelper
  def connect(baseurl, path)
	address = URI("#{baseurl}#{path}")
	request = Net::HTTP::Get.new address.request_uri
	http          = Net::HTTP.new address.host, address.port
	http.use_ssl  = true
	request.oauth! http, OAuth::Consumer.new("3Ft58U1DWj5Rzy31mZ7hQ",
		"tz6xjaYvhrRNZlPV2xBH7KJfqqf4v7tEef9oexj7I"),
		OAuth::Token.new("103690150-9TzmzmL8XQcPp8FBbvZeTybWXovCcgwQnmwenMwv",
    	"R8lnWa3a9Eq563ZKUGfH2GoD965FgJUuA2Z2R6I")  
	http.start
	resp = http.request request
  end

  def get_tweet_html(id)
  	address = URI("https://api.twitter.com/1/statuses/oembed.json?id=#{id}&omit_script=true&align=center&maxwidth=500")
	request = Net::HTTP::Get.new address.request_uri
	http = Net::HTTP.new address.host, address.port
	http.use_ssl = true
	http.start
	resp = http.request request
	JSON.parse(resp.body)["html"]
  end

  def get_tweets(player)
  	baseurl = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
	path = "screen_name=#{player}&count=4&include_rts=false&exclude_replies=true"

	response = connect(baseurl, path)
	tweets = JSON.parse(response.body)
	
	recent_tweets = []
	tweets.each do |tweet|
	  if DateTime.parse(tweet["created_at"]) + 3 >= DateTime.now
	    recent_tweets << tweet
	  end
	end
	return recent_tweets
  end

  def display_tweets(players)
  	tweets = []
 	players.each do |player|
	  tweets << get_tweets(player)
	end
	tweets.flatten!
	tweets.sort_by! { |t| DateTime.parse(t["created_at"]) }
	show_tweets(tweets.reverse)
  end

  def show_tweets(tweets)
	htmls = []
	tweets.each do |tweet|
	  htmls << get_tweet_html(tweet["id"])
	end
  	return htmls
  end

end
