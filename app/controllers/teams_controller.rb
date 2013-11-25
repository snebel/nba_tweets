class TeamsController < ApplicationController
  def index
  	#@teams = Team.search_for(params[:q])
  end

  def show
  	@team = Team.find(params[:id])
    #@twitter = Twitter.new
  end

  def new
  	@team = Team.new
  end

  def create
  end

  def update
  end
end
