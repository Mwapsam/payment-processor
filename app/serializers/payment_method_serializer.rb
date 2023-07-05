class PaymentMethodSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :payment_method_name, :payment_method_type, :fee_structure, :image

  def image
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end
end
