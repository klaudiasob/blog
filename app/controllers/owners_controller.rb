class OwnersController < ApplicationController

  def show
    @owner = Owner.find(params[:id])
  end

  def edit
    @owner = current_owner
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update!(owner_params)
      redirect_to @owner
    else
      render "edit"
    end
  end

  private

  def owner_params
    params.require(:owner).permit(:first_name, :last_name, :phone, :email)
  end


end
