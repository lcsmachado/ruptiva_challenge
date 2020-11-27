class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken

  include SimpleErrorRenderable
  self.simple_error_partial = 'shared/simple_error'

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:registration, keys: %i[first_name last_name email password password_confirmation role])
  end
end
