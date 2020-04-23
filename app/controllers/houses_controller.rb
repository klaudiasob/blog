# frozen_string_literal: true

class HousesController < ApplicationController
  before_action :set_house, only: %i[show edit update delete]

  load_and_authorize_resource

  def index_owner
    @houses = House.where(owner_id: current_owner.id).with_deleted
  end

  def index
    @houses = House.page(params[:page]).decorate
  end

  def show; end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    @house.owner = current_owner
    if @house.save!
      redirect_to @house
    else
      render 'new'
    end
  end

  def edit; end

  def destroy
    @house.destroy
    redirect_to myhouses_path
  end

  def update
    if @house.update!(house_params)
      category_ids = params[:house][:categories].drop(1)
      house_category_ids = @house.categories.pluck(:id)
      delete_ids = house_category_ids - category_ids
      delete_categories = @house.categories.where(id: delete_ids)
      @house.categories.delete(delete_categories)
      @house.categories << Category.where(id: category_ids)

      redirect_to @house
    else
      render 'edit'
    end
  end

  private

  def set_house
    @house = House.with_deleted.find(params[:id])
  end

  def house_params
    params.require(:house).permit(:area, :floors, :rooms, :price, :photo, :owner, :description,
                                  :land_area, :available_from, :market, :interior_finishing)
  end
end
