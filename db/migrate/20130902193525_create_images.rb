class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :product_id
      t.integer :color_id
      t.string :name

      t.timestamps
    end
  end
end
