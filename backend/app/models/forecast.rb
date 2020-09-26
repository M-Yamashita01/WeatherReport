class Forecast < ApplicationRecord
  validate :specified_forecast_type?

  belongs_to :weathermap_location
  has_many :sunrisesets
  has_many :temperatures
  has_many :atmospheric_pressures
  has_many :humidities
  has_many :clouds
  has_many :uv_indices
  has_many :winds
  has_many :rainfalls
  has_many :snowfalls

  def specified_forecast_type?
    forecast_type_list = ["current", "minutely", "hourly", "daily"]
    unless forecast_type_list.include?(forecast_type)
      errors.add(:forecast_type, "forecast_typeは指定文字列以外セットできません。")
    end
  end
end
