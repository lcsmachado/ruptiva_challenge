class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken

  include SimpleErrorRenderable
  self.simple_error_partial = 'shared/simple_error'
  
end
