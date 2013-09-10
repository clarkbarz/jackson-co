class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
    	t.belongs_to :product
    	t.string :color_one
    	t.string :color_two
    	t.string :color_thr

      t.timestamps
    end
  end
end
