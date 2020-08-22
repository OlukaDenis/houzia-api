class HousesController < ApplicationController
  
  def index
    @houses = House.all.order(created_at: :desc)
    json_response(@houses)
  end

  def create
    @house = current_user.houses.build(house_params)
    if current_user.admin
      @house.save!
      json_response(@house, :created)
    end
  end

  def show
    @house = House.find(params[:id])
    json_response(@house)
  end

  private

  def house_params
    params.permit(:name, :description, :image, :price)
  end
end
