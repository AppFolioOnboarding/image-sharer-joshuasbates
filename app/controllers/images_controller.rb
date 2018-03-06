require 'images_for_tag_name'

class ImagesController < ApplicationController
  include Images::ControllerHelper

  before_action :find_image, only: %i[show destroy]

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

  def destroy
    @image.destroy

    flash[:success] = 'You have successfully deleted the image.'
    redirect_to images_path
  end

  def index
    @images = ImagesForTagName.images(params[:tag_name])
  end

  def show; end

  private

  def find_image
    @image = image_by_id(params[:id])
  end

  def image_params
    params.require(:image).permit(:imageurl, :tag_list)
  end
end
