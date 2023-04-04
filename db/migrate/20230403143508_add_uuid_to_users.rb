class AddUuidToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uuid, :uuid
    add_column :users, :primary_key, :string
  end
end
