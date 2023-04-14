class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :phone_number
      t.string :name
      t.string :role, default: 'developer'
      t.string :password_digest

      t.timestamps
    end
  end
end
