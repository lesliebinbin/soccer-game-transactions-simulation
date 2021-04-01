class PlayersController < ApplicationController
  before_action :check_access
  def index
    players = current_user.players
    respond_to do |format|
      format.html { render locals: { players: players } }
      format.json do
        render json: players
      end
    end
  end

  def show
    current_player = Player.find(params[:id])
    respond_to do |format|
      format.html { render locals: { player: current_player } }
      format.json { render json: current_player }
    end
  end
end
