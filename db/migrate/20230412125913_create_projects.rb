class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name, limit: 100, null: false
      t.string :api_key, limit: 32, null: false, default: -> { "gen_random_uuid()" }
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :projects, :api_key, unique: true
  end
end