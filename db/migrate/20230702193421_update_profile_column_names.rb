class UpdateProfileColumnNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :provice, :province
  end
end
