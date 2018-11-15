class CreateBeta < ActiveRecord::Migration
  def change
    create_table :beta do |t|
      t.string :name
      t.string :email
      t.string :expected_number_listeners

      t.timestamps null: false
    end
  end
end
