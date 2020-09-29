# frozen_string_literal: true

class HousesController < ApplicationController
  before_action :set_house, only: %i[show edit update destroy]

  authorize_resource

  def index_owner
    @houses = House.where(owner_id: current_owner.id).with_deleted
  end

  def index
    @houses = House.page(params[:page]).decorate
  end

  def show
    @house = @house.decorate
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new
    @house.owner = current_owner
    result = HouseServices::Update.new(@house, house_params).call

    if result
      redirect_to @house, notice: 'House was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def destroy
    @house.destroy
    redirect_to root_path, notice: 'House was successfully destroyed.'
  end

  def update
    result = HouseServices::Update.new(@house, house_params).call
    if result
      redirect_to @house, notice: 'House was successfully updated.'
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
                                  :land_area, :available_from, :market, :interior_finishing, categories: [])
  end
end
