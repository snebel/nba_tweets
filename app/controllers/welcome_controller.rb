class WelcomeController < ApplicationController
  def index
  end

  def show
    @twitter = Twitter.new
  end
end
