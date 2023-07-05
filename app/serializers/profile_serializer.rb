class ProfileSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :full_name, :address, :phone_number, :email, :tpin, :business_name, :city, :province, :country, :latitude, :longitude, :selfie, :id_card

  def id_card
    rails_blob_path(object.id_card, only_path: true) if object.id_card.attached?
  end

  def selfie
    rails_blob_path(object.selfie, only_path: true) if object.selfie.attached?
  end
end
