class ImageSharesController < ApplicationController
  include Images::ControllerHelper

  before_action :find_image

  def create
    begin
      ImageMailer.share_image_email(@image, share_params[:email], share_params[:message]).deliver_now
      flash[:success] = 'You have successfully shared an image.'
    rescue Net::ProtocolError
      flash[:danger] = "We can't send email right now, please try again later"
    end
    respond_to do |format|
      format.html { redirect_to images_path }
      format.js
    end
  end

  private

  def find_image
    @image = image_by_id(params[:image_id])
  end

  def share_params
    params.require(:image).require(:share).permit(:email, :message)
  end
end
