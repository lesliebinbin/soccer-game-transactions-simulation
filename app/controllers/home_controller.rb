class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html { redirect_to rails_admin_path if current_user&.admin_role? }
      format.json { render json: current_user || [] }
    end
  end
end
