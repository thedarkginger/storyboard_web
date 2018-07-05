class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :street_address, :city, :state, :zip_code]

    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update,keys: added_attrs)
  end

  def after_sign_in_path_for(resource)
    if current_user.show
      new_podcast_path
    else
      new_show_path
    end
  end
end

