class AddForecastIdToWeatherGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :weather_groups, :forecast, foreign_key: true
  end
end
