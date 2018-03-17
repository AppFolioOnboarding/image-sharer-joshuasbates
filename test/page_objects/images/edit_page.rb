module PageObjects
  module Images
    class EditPage < PageObjects::Document
      path :edit_image
      path :image # from failed update

      is_loaded do
        node.first('.js-edit-page').present?
      end

      form_for :image do
        element :tag_list
      end

      def update_image!(tags: nil)
        tag_list.set(tags) if tags.present?
        node.click_button('Update')
        window.change_to(ShowPage, self.class)
      end
    end
  end
end
