# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    respond_to do |format|
      format.json do
        if current_user
          if current_user.admin_role?
            render json: { admin_user: current_user, admin_url: rails_admin_url }
          else
            render json: current_user, include: %i[team players]
          end
        else
          render json: { error: 'Sign In Failed' }, status: :unauthorized
        end
      end
      format.html { super }
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
