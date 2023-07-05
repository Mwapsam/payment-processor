class UserSerializer < ActiveModel::Serializer
  attributes :id, :phone_number, :name, :role, :email, :account_balance, :approved
end
