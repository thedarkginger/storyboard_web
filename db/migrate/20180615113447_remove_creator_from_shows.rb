class RemoveCreatorFromShows < ActiveRecord::Migration[5.2]
  def change
    remove_column :shows, :creator, :string
  end
end
