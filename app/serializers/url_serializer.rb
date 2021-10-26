class UrlSerializer < ActiveModel::Serializer
  attribute :id
  attributes :url, :original_url, :clicks_count, :created_at

  def url
    'https://domain/' + object.short_url
  end

  has_many :clicks, class_name: "relationships", foreign_key: "url_id"
end
