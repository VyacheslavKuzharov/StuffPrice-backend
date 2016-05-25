class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  require 'auth_token'


  protected

  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? ||
        !AuthToken.valid?(request.headers['Authorization'].split(' ').last)
  end
end
