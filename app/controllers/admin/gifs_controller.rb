class Admin::GifsController < ApplicationController
  def new
    @gif = Gif.new
  end

  def create
    @category = Category.find_or_create_by(name: gif_params[:search_term])
    @gif = @category.gifs.new(gif_params.merge(:image_url => get_gif_url))

    if @gif.save
      flash[:notice] = 'GIF saved!'
      redirect_to @gif
    else
    end
  end

  private

  def gif_params
    params.require(:gif).permit(:search_term)
  end

  def get_gif_url
    gif_data = Giphy.random(gif_params[:search_term])
    gif_data.image_original_url.to_s
  end
end
