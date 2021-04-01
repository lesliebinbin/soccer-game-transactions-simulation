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

  def update
    player = Player.find(params[:id])
    if player.current_employer.id != current_user.id
      head :unauthorized
    elsif player.update(player_params)
      head :ok
    else
      render json: { errors: player.errors }, status: :not_acceptable
    end
  end

  private

  def player_params
    params.require(:player).permit(:country, :first_name, :last_name)
  end
end
