require 'test_helper'

class ImageSharesControllerTest < ActionDispatch::IntegrationTest
  def test_should_get_new
    image = Image.create!(imageurl: 'http://abc.png')
    get new_image_image_share_path(image)
    assert_response :ok
  end

  def test_should_create_image_shares_email
    image = Image.create!(imageurl: 'http://abc.png')
    share_params = { share: { email: 'a@b.com' } }

    post image_image_shares_path(image), params: { image: share_params }

    assert_redirected_to images_path
    assert_equal 'You have successfully shared an image.', flash[:success]
  end

  def test_should_fail_to_create_image_shares_with_invalid_email
    image = Image.create!(imageurl: 'http://abc.png')
    share_params = { share: { email: 'abc' } }

    post image_image_shares_path(image), params: { image: share_params }

    assert_redirected_to new_image_image_share_path(image)
    assert_equal "You didn't give a valid email address", flash[:danger]
  end

  def test_should_fail_to_create_image_shares_with_proto_error
    image = Image.create!(imageurl: 'http://abc.png')
    share_params = { share: { email: 'a@b.com' } }

    ImageMailer.any_instance.stubs(:share_image_email).raises(Net::ProtocolError)

    post image_image_shares_path(image), params: { image: share_params }

    ImageMailer.any_instance.unstub(:share_image_email)

    assert_redirected_to new_image_image_share_path(image)
    assert_equal "We can't send email right now, please try again later", flash[:danger]
  end
end
