class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.text :description
      t.string :image
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
