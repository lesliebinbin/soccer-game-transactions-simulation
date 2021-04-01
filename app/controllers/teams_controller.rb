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
end
