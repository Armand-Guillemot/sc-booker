class Addingprivatetoreservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :is_private, :boolean, default: true
  end
end
