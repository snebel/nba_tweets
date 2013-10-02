

class Teams
  attr_accessor :rockets, :knicks, :players

  def initialize
  	@rockets = ["jharden13", "chandlerparsons" "jlin7"]
  	@knicks = ["therealjrsmith", "i_am_iman", "mettaworldpeace"]
  	@players = []
  end

  def create_players(team)
  	team.each do |player|
  		players << Person.new(player)
  	end
  end

end
