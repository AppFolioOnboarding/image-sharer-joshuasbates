require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_should_get_index
    get images_path
    assert_response :ok
    assert_select 'h1', 'Welcome!'
  end

  def test_should_order_index_by_created_at
    images = [
      Image.create!(imageurl: 'http://abc.png', created_at: Time.zone.now),
      Image.create!(imageurl: 'http://ghi.jpg', created_at: Time.zone.now - 1.day),
      Image.create!(imageurl: 'http://def.jpg', created_at: Time.zone.now - 2.days)
    ]

    get images_path
    assert_response :ok
    assert_select('table.image_table tr') do |image_rows|
      image_rows.each_with_index do |image_row, index|
        assert_select image_row, "img[src=\"#{images[index].imageurl}\"]", count: 1
      end
    end
  end

  def test_index_should_not_have_entries_if_no_images
    get images_path
    assert_response :ok
    assert_select 'table.image_table tr', count: 0
  end

  def test_should_get_new
    get new_image_path
    assert_response :ok
    assert_select 'h1', 'New Image'
  end

  def test_should_create_employee
    testimage = Image.create!(imageurl: 'http://abc.png')
    assert_difference('Image.count') do
      image_params = { imageurl: testimage.imageurl }
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
    testimage = Image.create!(imageurl: 'http://abc.png')
    get image_path(id: testimage.id)
    assert_response :ok
    assert_select('#image_url', 'http://abc.png')
  end
end
