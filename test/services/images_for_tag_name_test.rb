require 'test_helper'
require 'images_for_tag_name'

class ImagesForTagNameTest < ActiveSupport::TestCase
  def setup_images
    Image.create!(imageurl: 'http://abc.png', created_at: Time.zone.now, tag_list: %w[abc alphabet])
    Image.create!(imageurl: 'http://ghi.jpg', created_at: Time.zone.now - 1.day, tag_list: %w[ghi alphabet])
    Image.create!(imageurl: 'http://def.jpg', created_at: Time.zone.now - 2.days, tag_list: %w[def alphabet])
    Image.create!(imageurl: 'http://jk.jpg', created_at: Time.zone.now - 3.days) # no tags
  end

  def test_full_image_list_with_no_tag_name
    setup_images
    image_list = ImagesForTagName.images(nil)
    assert_equal 4, image_list.count
  end

  def test_filtered_image_list_with_unique_tag_name
    setup_images
    image_list = ImagesForTagName.images('abc')
    assert_equal 1, image_list.count
  end

  def test_filtered_image_list_with_shared_tag_name
    setup_images
    image_list = ImagesForTagName.images('alphabet')
    assert_equal 3, image_list.count
  end

  def test_filtered_image_list_with_unknown_tag_name
    setup_images
    image_list = ImagesForTagName.images('justkidding')
    assert_equal 0, image_list.count
  end

  def test_filtered_image_list_with_mutliple_tag_names
    setup_images
    image_list = ImagesForTagName.images(%w[abc alphabet])
    assert_equal 1, image_list.count
  end
end
