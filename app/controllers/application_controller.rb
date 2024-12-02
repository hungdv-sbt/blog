class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_gon

  def set_gon
    gon.is_login = current_user.present?
    return if current_user.blank?

    gon.user = {
      id: current_user&.id,
      name: current_user&.name
    }
  end

  def login?
    current_user.present?
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[birthday email password password_confirmation remember_me name address]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
