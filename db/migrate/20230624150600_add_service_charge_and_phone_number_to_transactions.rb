class AddServiceChargeAndPhoneNumberToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :service_charge, :decimal
    add_column :transactions, :phone_number, :string
  end
end
