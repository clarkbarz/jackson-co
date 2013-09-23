class AddSuffixToImages < ActiveRecord::Migration
  def change
  	add_column :images, :file_format, :string
  end
end
