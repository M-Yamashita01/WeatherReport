# frozen_string_literal: true

# class Micropost < ApplicationRecord
class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  scope :search, lambda { |params|
    search_by_user_id(params[:user_id])
  }

  scope :search_by_user_id, lambda { |user_id|
    return all if user_id.blank?

    where('microposts.user_id = ?', user_id)
  }
end
