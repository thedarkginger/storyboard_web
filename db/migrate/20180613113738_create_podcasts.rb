class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
        t.string :name
	    t.string :description
	    t.datetime :date
	    t.string :url
	    t.boolean :paywall
	    t.string  :audio_file
	    t.integer :show_id
        t.timestamps
    end
  end
end
