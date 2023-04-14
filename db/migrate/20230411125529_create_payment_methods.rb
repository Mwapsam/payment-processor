class CreatePaymentMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_methods, id: :uuid do |t|
      t.string :payment_method_type
      t.string :payment_method_name
      t.text :fee_structure

      t.timestamps
    end
  end
end
