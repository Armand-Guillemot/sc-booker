class Property < ApplicationRecord
  has_many_attached :photos
  has_one_attached :main_photo
  has_one_attached :avatar
  has_many :reservations

  include PgSearch
  pg_search_scope :search_by_name, against: :name,
  using: {
    :tsearch => {:prefix => true}
  }

  def available_now
    reservations = self.reservations.where.not(status:0)
    available = true
    reservations.each {|reservation| available = false if (Date.today).between?(reservation.start_date, reservation.end_date) }
    return available
  end

  def get_unavailable_days(reservation = nil)
    if reservation.present?
      confirmed_reservations = self.reservations.where.not(status:0).where.not(id: reservation.id)
    else
      confirmed_reservations = self.reservations.where.not(status:0)
    end

    result = []
    if confirmed_reservations.present?
      confirmed_reservations.each do |reservation|
        result_array = ((reservation.start_date.to_date + 1.day)..(reservation.end_date.to_date - 1.day)).map{ |date| date.strftime("%Y-%m-%d")}.to_a
        if result_array.uniq.count > 1
          result += result_array
        end
      end
    end
    return result.uniq
  end
end
