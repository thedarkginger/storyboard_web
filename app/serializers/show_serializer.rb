class ShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :creator, :image

  def image
    object.image.url
  end

  def creator
    object.user.first_name
  end
end
