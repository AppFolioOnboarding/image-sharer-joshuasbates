require 'images_for_tag_name'

class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image
    else
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
