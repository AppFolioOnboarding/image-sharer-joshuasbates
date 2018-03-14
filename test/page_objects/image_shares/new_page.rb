module PageObjects
  module ImageShares
    class NewPage < PageObjects::Document
      form_for :image do
        element :share_email
        element :share_message
      end

      def create_share!(email: nil, message: nil)
        share_email.set(email) if email.present?
        share_message.set(message) if message.present?
        node.click_button('Share')
        window.change_to(self.class)
      end
    end
  end
end
