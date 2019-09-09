class LocationOnForecastDay < ApplicationRecord
  belongs_to :location, foreign_key: :location_id, primary_key: :location_id
  belongs_to :weather, foreign_key: :weather_id, primary_key: :weather_id

  scope :search, lambda { |params|
    search_by_main_city_flag(params[:main_city_flag]).search_by_date(params[:date])
  }

  scope :search_by_main_city_flag, lambda { |main_city_flag|
    return all if main_city_flag.blank?

    where('locations.main_city_flag = ?', main_city_flag)
  }

  scope :search_by_date, lambda { |date|
    return all if date.blank?

    where('location_on_forecast_days.forecast_day = ?', date)
  }
end
