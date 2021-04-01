class TeamsController < ApplicationController
  before_action :check_access
  def show
    respond_to do |format|
      format.html
      format.json do
        render json: current_user.team, include: :players
      end
    end
  end

  def update
    if current_user.team.update(team_params)
      head :ok
    else
      render json: { error: current_user.team.errors }, status: :not_acceptable
    end
  end

  private

  def team_params
    params.require(:team).permit(:country, :name)
  end
end
