class CreateFees < ActiveRecord::Migration[7.0]
  def change
    create_table :fees, id: :uuid do |t|
      t.references :payment_method, null: false, foreign_key: true, type: :uuid
      t.decimal :transaction_amount
      t.decimal :fee_percentage

      t.timestamps
    end
  end
end
