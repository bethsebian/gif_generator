class GifsController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @gif = Gif.find(params[:id])
  end

  def destroy
    gif = Gif.find(params[:id])
    category = gif.category

    gif.destroy
    category.destroy if category.gifs.empty?

    redirect_to gifs_path
  end
end
