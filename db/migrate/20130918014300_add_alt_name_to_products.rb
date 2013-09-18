class AddAltNameToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :alt_name, :string
  end
end
