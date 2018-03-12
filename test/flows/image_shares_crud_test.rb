require 'flow_test_helper'

class ImageSharesCrudTest < FlowTestCase
  test 'share an image' do
    cute_puppy_url = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    Image.create!(imageurl: cute_puppy_url, tag_list: 'puppy, cute')

    images_index_page = PageObjects::Images::IndexPage.visit
    assert_equal 1, images_index_page.images.count
    assert images_index_page.showing_image?(url: cute_puppy_url)

    image_to_share = images_index_page.images.first
    image_show_page = image_to_share.view!

    new_image_shares_page = image_show_page.share_image!

    new_image_shares_page = new_image_shares_page.create_share!(
      email: 'abc',
      message: 'Hello World!'
    ).as_a(PageObjects::ImageShares::NewPage)

    message = page.find('#image_share_email').native.attribute('validationMessage')
    assert_equal 'Please enter an email address.', message

    new_image_shares_page.share_email.set('a@b.com')
    images_index_page = new_image_shares_page.create_share!.as_a(PageObjects::Images::IndexPage)
    assert_equal 'You have successfully shared an image.', images_index_page.flash_message(:success)
  end
end
