class PodcastSerializer < ActiveModel::Serializer
  attributes :podcast_id, :show, :episode, :date, :url, :description, :image, :paywall

  def date
    object.date && object.date.strftime("%d-%m-%Y")
  end

  def podcast_id
    object.id
  end

  def episode
    object.name
  end

  def url
    object.audio.url
  end

  def image
    object.show.image.thumb.url
  end

  def show
    object.show.name
  end

  def paywall
    object.paywall ? "yes" : "no"
  end
end
