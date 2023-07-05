class FeeSerializer < ActiveModel::Serializer
  attributes :id, :payment_method_id, :transaction_amount, :fee_percentage
end
