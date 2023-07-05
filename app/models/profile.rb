class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :id_card
  has_one_attached :selfie

  validates :user_id, uniqueness: true
  validates :full_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :tpin, presence: true
  validates :business_name, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :country, presence: true

  reverse_geocoded_by :latitude, :longitude do |obj|
    geo = Geocoder.search([obj.latitude, obj.longitude]).first

    if geo
      obj.city = geo.data['address']['state_district']
      obj.province = geo.data['address']['state']
      obj.country = geo.data['address']['country']
    end
  end

  before_validation :reverse_geocode, if: ->(obj) { obj.latitude.present? && obj.longitude.present? }
end
