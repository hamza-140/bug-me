class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :render_404


  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params[:role] = user_params[:role].to_i
      user_params.permit(:name, :email, :password, :password_confirmation, :role)
    end
  end

end
