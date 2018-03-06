class ImageMailer < ApplicationMailer
  default from: 'guns-n-ropes@appfolio.com'
  layout 'mailer'

  def share_image_email(image, email, message)
    @image = image
    @message = message
    @show_page_url = image_url(image)
    mail(to: email, subject: 'An Image is Being Shared with You')
  end
end
