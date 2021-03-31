class HomeController < ApplicationController
  def index
    redirect_to rails_admin_path if current_user&.admin_role?
  end
end
