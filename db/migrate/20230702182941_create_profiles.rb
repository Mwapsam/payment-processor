class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :full_name
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :tpin
      t.string :business_name
      t.string :city
      t.string :provice
      t.string :country
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :profiles, [:latitude, :longitude]
  end
end
