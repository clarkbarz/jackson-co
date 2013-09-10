class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
    	t.belongs_to :product
    	t.string :content

      t.timestamps
    end
  end
end
