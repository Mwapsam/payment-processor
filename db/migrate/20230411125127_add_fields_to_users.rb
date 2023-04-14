class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
    add_column :users, :account_balance, :integer, default: 0
  end
end
