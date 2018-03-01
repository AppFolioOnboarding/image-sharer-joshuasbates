module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      def url?(url)
        node.find("img[src=\"#{url}\"]").present?
      end

      def image_url
        node.find('img')[:src]
      end

      def tags
        node.all('.badge').map(&:text)
      end

      def delete
        node.click_on('Delete')
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.click_on('Delete')
        node.driver.browser.switch_to.alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on('Index')
        window.change_to(IndexPage)
      end

      def share_image!
        node.click_on('Share image')
        window.change_to(ImageShares::NewPage)
      end
    end
  end
end
