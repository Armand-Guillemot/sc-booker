class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.boolean :reservable
      t.integer :property_type
      t.integer :capacity
      t.integer :bedrooms
      t.integer :bathrooms

      t.timestamps
    end
  end
end
