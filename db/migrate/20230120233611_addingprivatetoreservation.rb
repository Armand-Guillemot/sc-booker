class Addingprivatetoreservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :private, :boolean, default: true
  end
end
