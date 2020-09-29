# frozen_string_literal: true

module ControllerMacros
  def login_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      admin = FactoryBot.create(:owner, :admin)
      sign_in admin # sign_in(scope, resource)
    end
  end

  def login_owner
    before do
      @request.env['devise.mapping'] = Devise.mappings[:owner]
      owner = FactoryBot.create(:owner)
      sign_in owner
    end
  end
end
