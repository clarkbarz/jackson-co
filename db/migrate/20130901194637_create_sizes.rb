class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.belongs_to :product
      t.belongs_to :color
      t.string :letter

      t.timestamps
    end
  end
end
