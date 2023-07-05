class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :payment_method_id, :transaction_status, :transaction_amount, :transaction_id, :transaction_timestamp, :service_charge, :phone_number
end
