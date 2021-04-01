class ApplicationController < ActionController::Base
  # protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery unless: -> { true }
  rescue_from CanCan::AccessDenied do |e|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_path, alert: e.message }
    end
  end

  protected

  def check_access
    head :unauthorized unless signed_in?
    # respond_to do |format|
    #   format.html { redirect_to root_path, alert: 'Please Login First' unless current_user }
    #   format.json { render json: { error: 'Unauthorised' }, status: :unauthorized }
    # end
  end
end
