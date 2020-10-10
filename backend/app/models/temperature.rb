# frozen_string_literal: true

class Temperature < ApplicationRecord
  belongs_to :forecast
end
