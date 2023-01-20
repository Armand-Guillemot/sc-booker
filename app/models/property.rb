class Property < ApplicationRecord
  has_many_attached :photos
  has_one_attached :main_photo
  has_many :reservations
end
