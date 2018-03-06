class ImageSharesController < ApplicationController
  include Images::ControllerHelper

  before_action :find_image
  before_action :validate_email, only: :create

  def new; end

  def create
    ImageMailer.share_image_email(@image, share_params[:email], share_params[:message]).deliver_now
    flash[:success] = 'You have successfully shared an image.'
    redirect_to images_path
  rescue Net::ProtocolError
    flash[:danger] = "We can't send email right now, please try again later"
    redirect_to new_image_image_share_path(@image)
  end

  private

  def find_image
    @image = image_by_id(params[:image_id])
  end

  def validate_email
    form = Forms::ImageSharesForm.new(share_params[:email], share_params[:message])
    return if form.valid?
    flash[:danger] = "You didn't give a valid email address"
    redirect_to new_image_image_share_path(@image)
  end

  def share_params
    params.require(:image).require(:share).permit(:email, :message)
  end
end
