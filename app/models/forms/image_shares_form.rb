module Forms
  class ImageSharesForm
    include ActiveModel::Validations

    attr_accessor :email, :message

    validates :email, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

    def initialize(email, message)
      self.email = email
      self.message = message
    end
  end
end
