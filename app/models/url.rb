class Url < ApplicationRecord
  has_many :clicks

  validates :original_url, presence: true
  validates :original_url, uniqueness: true, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix }
  validates :short_url, presence:true
  validates_length_of :short_url, minimum: 5, maximum: 5
end
