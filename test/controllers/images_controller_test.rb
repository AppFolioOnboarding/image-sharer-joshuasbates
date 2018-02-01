require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testimage = Image.create!(imageurl: 'http://abc.png')
  end

  def test_should_get_index
    get images_path
    assert_response :ok
    assert_select 'h1', 'Listing Image URLs'
  end

  def test_should_get_new
    get new_image_path
    assert_response :ok
    assert_select 'h1', 'New Image URL'
  end

  def test_should_create_employee
    assert_difference('Image.count') do
      image_params = { imageurl: @testimage.imageurl }
      post images_path, params: { image: image_params }
    end
    assert_redirected_to image_path(Image.last)
  end

  def test_should_fail_to_create_with_invalid_data
    assert_no_difference('Image.count') do
      image_params = { imageurl: 'abc.png' }
      post images_path, params: { image: image_params }
    end

    assert_response :ok
    assert_select('#error_explanation ul li', 'Imageurl is invalid')
    assert_select 'ul' do
      assert_select 'li', 1
    end
  end

  def test_should_show_image
    get image_path(id: @testimage.id)
    assert_response :ok
    assert_select('#image_url', 'http://abc.png')
  end
end
