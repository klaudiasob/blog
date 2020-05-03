# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = %i[password password_confirmation current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def current_ability
    @current_ability ||= Ability.new(current_owner)
  end

  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end
end
