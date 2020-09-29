# frozen_string_literal: true

class OwnersController < ApplicationController
  load_and_authorize_resource

  def edit
    @owner = current_owner
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update(owner_params)
      redirect_to root_path, notice: 'User was successfully updated.'
    else
      render 'edit'
    end
  end

  private

  def owner_params
    params.require(:owner).permit(:first_name, :last_name, :phone, :email)
  end
end
