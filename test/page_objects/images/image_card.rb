module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def url
        node.find('img')[:src]
      end

      def tags
        node.all('.js-card-tag').map(&:text)
      end

      def click_tag!(tag_name)
        node.click_on(tag_name)
      end
    end
  end
end
