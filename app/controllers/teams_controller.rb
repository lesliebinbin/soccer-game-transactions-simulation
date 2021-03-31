class TeamsController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.json do
        render json: current_user.team, include: :players
      end
    end
  end
end
