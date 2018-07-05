class RemoveUrlFromPodcasts < ActiveRecord::Migration[5.2]
  def change
    remove_column :podcasts, :url, :string
  end
end
