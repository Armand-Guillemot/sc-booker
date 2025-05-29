class Addingmaintainertouser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :maintenance, :boolean, default: false
  end
end
