class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :property, null: false, foreign_key: true
      t.integer :guest_count
      t.integer :days
      t.text :comment
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
