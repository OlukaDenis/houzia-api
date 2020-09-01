class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites.all
    json_response(@favorites)
  end

  def create
    @favorite = current_user.favorites.create(favorite_params)
    json_response(@favorite, :created)
  end

  def destroy
    @favorite = Favorite.find_by(id: params[:id], user: current_user, house_id: params[:house_id])
    @favorite.destroy
    head :no_content
  end

  private

  def favorite_params
    params.permit(:house_id)
  end
end
