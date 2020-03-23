class HousesController < ApplicationController
  before_action :authenticate_owner!, except: [:index, :show]
  before_action :set_house, only: [:show, :edit, :update]
  before_action :check_ownership, except: [:index, :show, :new]


  def index
    if params[:query]
      @houses = House.where(floors: params[:query].to_i)
    else
      @houses = House.all
    end
  end

  def show
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
      render "edit"
    end
  end

  private

  def set_house
    @house = House.find(params[:id])
  end

  def check_ownership
    return if current_owner == @house.owner

    redirect_to root_path
  end

  def house_params
    params.require(:house).permit(:area, :floors, :rooms, :price, :photo, :owner, :description, :land_area, :available_from, :market, :interior_finishing)
  end
end
