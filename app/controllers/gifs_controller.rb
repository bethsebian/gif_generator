class GifsController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @gif = Gif.find(params[:id])
  end
end
