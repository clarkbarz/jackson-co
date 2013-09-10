class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :product
      t.belongs_to :color
      t.string :name

      t.timestamps
    end
  end
end
