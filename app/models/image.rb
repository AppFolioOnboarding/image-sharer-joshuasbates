require 'uri'

class Image < ApplicationRecord
  acts_as_taggable

  validates :imageurl, presence: true
  validates :imageurl, format: URI::DEFAULT_PARSER.make_regexp
  validates :imageurl,
            format: { with: /\.(gif|jpe?g|png)/i,
                      message: 'must have an image extension' }

  validates :tag_list, presence: true
  validates :tag_list, length: { in: 1..5, message: 'No more than 5 tags are allowed per image' }
  validate :check_tag_is_valid

  def check_tag_is_valid
    tag_list.each do |tag|
      if tag.size > 20
        errors.add(:tag_list, 'Tags must be shorter than 20 characters')
      end
      errors.add(:tag_list, 'Tag must not be <unset>') if tag == '<unset>'
    end
  end
end
