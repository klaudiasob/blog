# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    edit_owner_path(resource)
  end
end
