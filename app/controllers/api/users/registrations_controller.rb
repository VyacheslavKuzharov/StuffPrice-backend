class Api::Users::RegistrationsController < Devise::RegistrationsController
  require 'auth_token'

  # Disable CSRF protection
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)

        token = AuthToken.issue_token({ user_id: resource.id })
        respond_to do |format|
          format.json { render json: {id: resource.id, email: resource.email, token: token} }
        end
      else
        super
      end
    else
      super
    end
  end
end