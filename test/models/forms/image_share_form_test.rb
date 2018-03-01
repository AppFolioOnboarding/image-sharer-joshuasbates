require 'test_helper'

class ImageShareFormTest < ActiveSupport::TestCase
  def test_image_share_email_is_valid
    form = Forms::ImageSharesForm.new('a@b.com', ' ')
    assert form.valid?
  end

  def test_image_share_email_is_valid_containing_dot
    form = Forms::ImageSharesForm.new('a.c@b.com', ' ')
    assert form.valid?
  end

  def test_image_share_email_is_valid_containing_dot_in_subdomain
    form = Forms::ImageSharesForm.new('a@b.c.com', ' ')
    assert form.valid?
  end

  def test_image_share_email_is_valid_containing_underscore
    form = Forms::ImageSharesForm.new('___@b.com', ' ')
    assert form.valid?
  end

  # Expected invalid test cases

  def test_image_share_email_is_not_valid_if_blank
    form = Forms::ImageSharesForm.new('', ' ')
    refute form.valid?
  end

  def test_image_share_email_is_not_valid_with_plain_text
    form = Forms::ImageSharesForm.new('plaintext', ' ')
    refute form.valid?
  end

  def test_image_share_email_is_not_valid_with_garbage
    form = Forms::ImageSharesForm.new('#@%^%#$_#$!#.com	', ' ')
    refute form.valid?
  end

  def test_image_share_email_is_not_valid_without_user_name
    form = Forms::ImageSharesForm.new('@b.com', ' ')
    refute form.valid?
  end

  def test_image_share_email_is_not_valid_with_0_ats
    form = Forms::ImageSharesForm.new('a.b.com', ' ')
    refute form.valid?
  end

  def test_image_share_email_is_not_valid_with_2_ats
    form = Forms::ImageSharesForm.new('a@b@c.com', ' ')
    refute form.valid?
  end

  def test_image_share_email_is_not_valid_without_domain
    form = Forms::ImageSharesForm.new('a@b', ' ')
    refute form.valid?
  end

  def test_image_share_email_is_not_valid_with_2_dot_domain
    form = Forms::ImageSharesForm.new('a@b..com', ' ')
    refute form.valid?
  end
end
