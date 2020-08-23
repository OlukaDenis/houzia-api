class HousesController < ApplicationController
  before_action :require_admin, except: %i[index show]
  before_action :house, only: %i[show update destroy]

  def index
    @houses = House.all.order(created_at: :desc)
    json_response(@houses)
  end

  def create
    @house = current_user.houses.build(house_params)
      @house.save!
      json_response(@house, :created)
  end

  def show
    @favorites = current_user.favorites.any? { |hse| hse.house_id == @house.id }
    @response = { house: @house, favorites: @favorites }
    json_response(@response)
  end

  def update
    @house.update!(house_params)
    json_response(@house)
  end

  def destroy
    @house.destroy
    head :no_content
  end

  private

  def house_params
    params.permit(:name, :description, :image, :price)
  end

  def require_admin
    raise(ExceptionHandler::InvalidToken, Message.no_admin) unless current_user.admin
  end

  def house
    @house = House.find(params[:id])
  end
end
