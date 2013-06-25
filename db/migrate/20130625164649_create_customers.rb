class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :email

      t.timestamps
    end
    add_index :customers, :email, unique: true
    add_column :customers, :password_digest, :string
  end
end
