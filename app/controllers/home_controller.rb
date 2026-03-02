class HomeController < ApplicationController
  def index
    @pamphlet_versions = PamphletVersion.includes(:cards).all
  end
end
