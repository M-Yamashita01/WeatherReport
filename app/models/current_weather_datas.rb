class CurrentWeatherDatas < ApplicationRecord
  belongs_to :weather_group, foreign_key: :weather_group_id, primary_key: :id
  belongs_to :weathermap_location, foreign_key: :weathermap_location_id, primary_key: :id

  scope :search, lambda { |params|
    search_by_less_than_longitude(params[:longitude_max]).search_by_more_than_longitude(params[:longitude_min]).search_by_less_than_latitude(params[:latitude_max]).search_by_more_than_latitude(params[:latitude_min]).exist_city_ja()
  }

  scope :search_by_less_than_longitude, lambda { |longitude|
    return all if longitude.blank?

    where('weathermap_locations.longitude <= ?', longitude)
  }

  scope :search_by_more_than_longitude, lambda { |longitude|
    return all if longitude.blank?

    where('weathermap_locations.longitude >= ?', longitude)
  }

  scope :search_by_less_than_latitude, lambda { |latitude|
    return all if latitude.blank?

    where('weathermap_locations.latitude <= ?', latitude)
  }

  scope :search_by_more_than_latitude, lambda { |latitude|
    return all if latitude.blank?

    where('weathermap_locations.latitude >= ?', latitude)
  }

  scope :exist_city_ja, lambda {
    where('weathermap_locations.city_name_ja != ""')
  }
end
