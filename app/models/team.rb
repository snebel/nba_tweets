

class Teams
  attr_accessor :rockets, :knicks, :players

  def initialize(team)
    @team = team
  end

  def create_players(team)
  	team.each do |player|
  		players << Person.new(player)
  	end
  end

end
