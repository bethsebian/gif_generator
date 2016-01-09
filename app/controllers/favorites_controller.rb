class FavoritesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def create
    fav = Favorite.create(favorite_params)
    redirect_to user_favorites_path(current_user)
  end

  private

  def favorite_params
    params.permit(:gif_id, :user_id)
  end
end
