# frozen_string_literal: true

# class WeathermapLocation < ApplicationRecord
class WeathermapLocation < ApplicationRecord
  validates :city_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :city_name, presence: true
end
