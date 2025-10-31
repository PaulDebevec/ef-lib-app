class AddStatusToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :status, :string, default: "pending", null: false
    add_index :books, :status
  end
end