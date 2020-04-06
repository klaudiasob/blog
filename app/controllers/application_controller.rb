# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
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
