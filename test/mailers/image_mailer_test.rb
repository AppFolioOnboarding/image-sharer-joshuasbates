require 'test_helper'

class ImageMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  test 'invite' do
    # Create the email and store it for further assertions
    image = Image.create!(imageurl: 'http://abc.png')
    message = 'Hi! You are receiving a message'
    email = ImageMailer.share_image_email(image, 'you@example.com', message)

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['guns-n-ropes@appfolio.com'], email.from
    assert_equal ['you@example.com'], email.to
    assert_equal 'An Image is Being Shared with You', email.subject
    assert_equal read_fixture('share.text').join, email.text_part.body.to_s

    assert_select_email do
      assert_select 'p', text: message
      assert_select "img[src='#{image.imageurl}']"

      expected_show_url = image_url(image)
      assert_select "a[href='#{expected_show_url}']"
    end
  end
end
