class FavoritesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def show
    @gif = Favorite.find(params[:id]).gif
  end

  def create
    fav = Favorite.create(favorite_params)
    redirect_to user_favorites_path(current_user)
  end

  def destroy
    Favorite.find_by(gif_id: params[:id], user_id: params[:user_id]).delete
    redirect_to user_favorites_path(current_user)
  end

  private

  def favorite_params
    params.permit(:gif_id, :user_id)
  end
end
