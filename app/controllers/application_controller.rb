class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
end
