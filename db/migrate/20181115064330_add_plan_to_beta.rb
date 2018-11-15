class AddPlanToBeta < ActiveRecord::Migration
  def change
    add_column :beta, :plan, :string
  end
end
