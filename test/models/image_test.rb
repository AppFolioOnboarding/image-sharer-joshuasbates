require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image_url_is_invalid_if_empty_url
    url = Image.new(imageurl: nil)
    refute_predicate url, :valid?
  end

  def test_image_url_is_invalid_if_not_a_url
    url = Image.new(imageurl: 'abc', tag_list: 'test')
    refute_predicate url, :valid?
  end

  def test_image_url_is_invalid_if_not_a_http_url
    url = Image.new(imageurl: 'ftp://abc.com', tag_list: 'test')
    refute_predicate url, :valid?
  end

  def test_image_url_is_invalid_if_not_an_image
    url = Image.new(imageurl: 'http://abc.com', tag_list: 'test')
    refute_predicate url, :valid?
  end

  def test_image_url_is_valid_if_a_png_image
    url = Image.new(imageurl: 'http://abc.png', tag_list: 'test')
    assert_predicate url, :valid?
  end

  def test_image_url_is_valid_if_a_jpg_image
    url = Image.new(imageurl: 'http://abc.jpg', tag_list: 'test')
    assert_predicate url, :valid?
  end

  def test_image_url_is_valid_if_a_jpeg_image
    url = Image.new(imageurl: 'http://abc.jpeg', tag_list: 'test')
    assert_predicate url, :valid?
  end

  def test_image_url_is_valid_if_a_gif_image
    url = Image.new(imageurl: 'http://abc.gif', tag_list: 'test')
    assert_predicate url, :valid?
  end

  def test_image_has_no_tags
    img = Image.new(imageurl: 'http://abc.gif')
    refute_predicate img, :valid?
  end

  def test_image_initialized_with_tags
    img = Image.new(imageurl: 'http://abc.gif', tag_list: 'a, b, c')
    assert_not_empty img.tag_list
    assert_equal 3, img.tag_list.count
  end
end
