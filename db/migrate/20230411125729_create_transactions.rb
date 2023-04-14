class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :payment_method, null: false, foreign_key: true, type: :uuid
      t.string :transaction_status
      t.decimal :transaction_amount
      t.string :transaction_id
      t.datetime :transaction_timestamp

      t.timestamps
    end
  end
end
