class Forecast < ApplicationRecord
  validate :specified_forecast_type?

  belongs_to :weathermap_location
  has_many :sunrisesets
  has_many :temperatures

  def specified_forecast_type?
    forecast_type_list = ["current", "minutely", "hourly", "daily"]
    unless forecast_type_list.include?(forecast_type)
      errors.add(:forecast_type, "forecast_typeは指定文字列以外セットできません。")
    end
  end
end
