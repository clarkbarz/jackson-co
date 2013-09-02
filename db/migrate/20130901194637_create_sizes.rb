class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.integer :product_id
      t.integer :color_id
      t.string :letter

      t.timestamps
    end
  end
end
