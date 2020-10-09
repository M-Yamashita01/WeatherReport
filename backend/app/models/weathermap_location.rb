# frozen_string_literal: true

# class WeathermapLocation < ApplicationRecord
class WeathermapLocation < ApplicationRecord
  validates :city_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :city_name, presence: true

  has_many :forecasts

  scope :search_location, lambda { |latitude, longitude|
    return none if latitude.blank? || longitude.blank?

    where(latitude: latitude, longitude: longitude)
  }
end
