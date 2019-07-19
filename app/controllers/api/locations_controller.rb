class Api::LocationsController < ApplicationController
  def index
    @location = Location.order('updated_at DESC')
  end
end
