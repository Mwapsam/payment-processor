class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :api_key, :user_id
end
