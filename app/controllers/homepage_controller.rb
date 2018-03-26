class HomepageController < ApplicationController
  def index
    # Store all of the games from the model in an instance variable so the view can access them
    @games = Game.limit(5)
  end
end
