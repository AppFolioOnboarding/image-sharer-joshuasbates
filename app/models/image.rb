require 'uri'

class Image < ApplicationRecord
  acts_as_taggable

  validates :imageurl, presence: true
  validates :imageurl, format: URI::DEFAULT_PARSER.make_regexp
  validates :imageurl,
            format: { with: /\.(gif|jpe?g|png)/i,
                      message: 'must have an image extension' }
  validates :tag_list, presence: true
end
