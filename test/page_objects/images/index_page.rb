module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: '.album', item_locator: '.card', contains: Images::ImageCard do
        def view!
          node.find('.js-image-link').click
          window.change_to(ShowPage)
        end

        def click_tag!(tag:)
          node.click_on(tag)
          window.change_to(IndexPage)
        end
      end

      def add_new_image!
        node.click_on('New')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        images.any? do |image|
          result = image.url == url
          tags.present? ? (result && image.tags == tags) : result
        end
      end

      def clear_tag_filter!
        node.click_on('Clear')
        window.change_to(self.class)
      end
    end
  end
end
