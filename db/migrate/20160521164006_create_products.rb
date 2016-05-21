class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :image
      t.integer :views

      t.timestamps null: false
    end
  end
end
