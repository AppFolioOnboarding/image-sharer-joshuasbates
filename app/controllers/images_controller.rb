require 'images_for_tag_name'

class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      flash[:success] = 'You have successfully added an image.'
      redirect_to @image
    else
      flash.now[:danger] = 'There was an error adding the image.'
      render 'new'
    end
  end

  def index
    @images = ImagesForTagName.images(params[:tag_name])
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:imageurl, :tag_list)
  end
end
