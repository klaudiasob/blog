class HousesController < ApplicationController
  before_action :authenticate_owner!, except: [:index, :show]

  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    @house.owner = current_owner
    if @house.save!
      redirect_to @house
    else
      render "new"
    end
  end

  def edit
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])
    if @house.update!(house_params)
      redirect_to @house
    else
      render "edit"
    end
  end

  private

  def house_params
    params.require(:house).permit(:area, :floors, :rooms, :price, :photo)
  end
end
