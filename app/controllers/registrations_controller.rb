class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_sign_up_path_for(resource)
    edit_owner_path(resource)
  end
end