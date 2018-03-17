# rubocop:disable Metrics/ClassLength

require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_should_get_index
    get images_path
    assert_response :ok
  end

  def test_should_order_index_by_created_at
    images = [
      Image.create!(imageurl: 'http://abc.png', created_at: Time.zone.now, tag_list: 'abc'),
      Image.create!(imageurl: 'http://ghi.jpg', created_at: Time.zone.now - 1.day, tag_list: 'ghi'),
      Image.create!(imageurl: 'http://def.jpg', created_at: Time.zone.now - 2.days, tag_list: 'def')
    ]

    get images_path
    assert_response :ok
    assert_select '.album', count: 1 do
      assert_select '.card', count: 3 do |cards|
        cards.each_with_index do |card, index|
          assert_select card, "img[src=\"#{images[index].imageurl}\"]", count: 1
        end
      end
    end
  end

  def test_index_should_not_have_entries_if_no_images
    get images_path
    assert_response :ok
    assert_select '.album', count: 1 do |_album|
      assert_select '.card', count: 0
    end
  end

  def test_should_get_new
    get new_image_path
    assert_response :ok
  end

  def test_should_create_image
    expected_url = 'http://abc.png'
    expected_tag_list = 'a, b, c'
    assert_difference('Image.count') do
      image_params = { imageurl: expected_url, tag_list: expected_tag_list }
      post images_path, params: { image: image_params }
    end

    last_image = Image.last
    assert_redirected_to image_path(last_image)
    assert_equal 'You have successfully added an image.', flash[:success]

    assert_equal expected_url, last_image.imageurl
    assert_equal expected_tag_list, last_image.tag_list.join(', ')
  end

  def test_should_fail_to_create_with_invalid_data
    assert_no_difference('Image.count') do
      image_params = { imageurl: 'abc.png', tag_list: '' }
      post images_path, params: { image: image_params }
    end

    assert_response :ok
    assert_equal 'There was an error adding the image.', flash[:danger]
    assert_select '#new_image' do
      assert_select '.help-block', 'is invalid'
    end
  end

  def test_should_maintain_form_with_invalid_data
    tag_list = 'a, b, c'
    assert_no_difference('Image.count') do
      image_params = { imageurl: 'abc.png', tag_list: tag_list }
      post images_path, params: { image: image_params }
    end

    assert_response :ok
    assert_select '.image_tag_list' do
      assert_select 'input[value=?]', tag_list
    end
  end

  def test_should_enable_editing
    image = Image.create!(imageurl: 'http://abc.png', tag_list: 'abc')
    get edit_image_path(image)
    assert_response :ok
  end

  def test_should_fail_update_with_invalid_data
    image = Image.create!(imageurl: 'http://abc.png', tag_list: 'abc')
    image_params = { tag_list: '1,2,3,4,5,6' }
    patch image_path(image), params: { image: image_params }
    assert_equal 'There was an error updating the image tags.', flash[:danger]
  end

  def test_should_update_with_valid_data
    image = Image.create!(imageurl: 'http://abc.png', tag_list: 'abc')
    image_params = { tag_list: '1,2,3,4' }
    patch image_path(image), params: { image: image_params }
    assert_equal 'You have successfully updated the image tags.', flash[:success]

    found_image = Image.find(image.id)
    assert_equal '1, 2, 3, 4', found_image.tag_list.join(', ')
  end

  def test_should_show_image
    testimage = Image.create!(imageurl: 'http://abc.png', tag_list: 'test')
    get image_path(id: testimage.id)
    assert_response :ok
    assert_select "img[src='http://abc.png']", count: 1
    assert_select '.js-card-tag', count: 1 # no tags block
  end

  def test_should_show_image_not_found
    get image_path(id: '-1')
    assert_redirected_to images_path
    assert_equal 'Image was not found.', flash[:danger]
  end

  def test_should_show_image_with_tags_alphabetically
    testimage = Image.create!(imageurl: 'http://abc.png', tag_list: 'c, d, b, a')
    expected_names = %w[a b c d]

    get image_path(id: testimage.id)
    assert_response :ok
    assert_select "img[src='http://abc.png']", count: 1

    assert_select '.js-tags-list', count: 1 do
      assert_select 'a', count: 4 do |buttons|
        buttons.each_with_index do |_button, index|
          assert_select 'a', expected_names[index]
        end
      end
    end
  end

  def test_should_delete_image_with_flash_message
    testimage = Image.create!(imageurl: 'http://abc.png', tag_list: 'c, b, a')

    assert_difference('Image.count', -1) do
      delete image_path(testimage)
    end
    assert_redirected_to images_path
    assert_equal 'You have successfully deleted the image.', flash[:success]
  end

  def test_should_delete_image_fails
    # Try deleting an image ID that does not exist
    assert_difference('Image.count', 0) do
      delete image_path(-1)
    end
    assert_redirected_to images_path
    assert_equal 'Image was not found.', flash[:danger]
  end
end
