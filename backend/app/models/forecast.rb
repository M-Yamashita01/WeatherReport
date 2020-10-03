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
  has_many :weather_groups

  scope :search_current_forecast_by_location, ->(weathermap_location_id) {
    return none if weathermap_location_id.blank?

    conditions = {
      forecast_type: "current",
      weathermap_location_id: weathermap_location_id
    }
    left_joins(
      :sunrisesets,
      :temperatures,
      :atmospheric_pressures,
      :humidities,
      :clouds,
      :uv_indices,
      :winds,
      :rainfalls,
      :snowfalls,
      :weather_groups
    ).where(conditions)
  }

  scope :search_daily_forecast_by_location, ->(weathermap_location_id) {
    return none if weathermap_location_id.blank?
    
    conditions = {
      forecast_type: "daily",
      weathermap_location_id: weathermap_location_id
    }

    left_joins(
      :sunrisesets,
      :temperatures,
      :atmospheric_pressures,
      :humidities,
      :clouds,
      :uv_indices,
      :winds,
      :rainfalls,
      :snowfalls,
      :weather_groups
    ).where(conditions).select('*')
  }

  def specified_forecast_type?
    forecast_type_list = ["current", "minutely", "hourly", "daily"]
    unless forecast_type_list.include?(forecast_type)
      errors.add(:forecast_type, "forecast_typeは指定文字列以外セットできません。")
    end
  end


end
