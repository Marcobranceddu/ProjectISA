# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :organizer, foreign_key: :organizer_id, class_name: 'User'
  has_many :participations
  has_many :participants, through: :participations, source: :user

  geocoded_by :address
  after_validation :geocode

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :max_participants, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true

  def joined?(user)
    !!participations.find_by(user_id: user.id)
  end

  def is_banned?(user)
    !!participations.find_by(user_id: user.id).is_banned
  end

  def address
    [street, city, state, country].compact.join(', ')
  end

  scope :with_name_like, lambda { |query|
    where('name LIKE ?', "%#{query}%")
  }

  scope :near_city, lambda { |city|
    near(city.to_s, 20, units: :km)
  }

  scope :overlapping, lambda { |start_date, end_date|
    where(start_date: start_date..end_date)
      .or(where(end_date: start_date..end_date))
      .or(
        where(start_date: ..start_date)
        .where(end_date: end_date..)
      )
  }
end
