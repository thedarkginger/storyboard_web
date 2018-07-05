class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.string :name
	    t.string :description
	    t.string :creator
	    t.string :image
	    t.integer :user_id
      t.timestamps
    end
  end
end
