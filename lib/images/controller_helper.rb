module Images
  module ControllerHelper
    private

    def image_by_id(image_id)
      Image.find(image_id)
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = 'Image was not found.'
      redirect_to images_path
    end
  end
end
