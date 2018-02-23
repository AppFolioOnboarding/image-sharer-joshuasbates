module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images # from failed create

      form_for :image do
        element :imageurl
        element :tag_list
      end

      def create_image!(url: nil, tags: nil)
        imageurl.set(url) if url.present?
        tag_list.set(tags) if tags.present?
        node.click_button('Save Image')
        window.change_to(ShowPage, self.class) # last param could be NewPage
      end
    end
  end
end
