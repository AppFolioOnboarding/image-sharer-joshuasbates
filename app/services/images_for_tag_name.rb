class ImagesForTagName
  def self.images(tag_name)
    image_list = if tag_name.nil?
                   Image.order(created_at: :desc)
                 else
                   Image.tagged_with(tag_name).order(created_at: :desc)
                 end
    image_list
  end
end
