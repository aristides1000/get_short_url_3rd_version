class ClickSerializer < ActiveModel::Serializer
  attributes :id, :browser, :platform, :created_at

  belongs_to :url, serializer: UrlSerializer
end
