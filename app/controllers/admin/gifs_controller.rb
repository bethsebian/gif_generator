class Admin::GifsController < ApplicationController
  before_action :verify_admin #, only: [:new, :create]

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

  def verify_admin
    if current_user && current_user.admin?
    else
      
      render file: 'public/404'
    end
    #
    # unless current_user && current_user.admin?
    #   redirect_to file: 'public/404'
    # end
  end

  def gif_params
    params.require(:gif).permit(:search_term)
  end

  def get_gif_url
    gif_data = Giphy.random(gif_params[:search_term])
    gif_data.image_original_url.to_s
  end
end
