# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class ImageMailerPreview < ActionMailer::Preview
  def share_image_email
    ImageMailer.share_image_email(Image.first, 'starbuck@galactica.com')
  end
end
