class AddingRoleToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :first_name, :string
  end
end
