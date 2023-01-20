class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property
  validate :date_range

  def date_range

    if property.reservations.where.not(id: id).where(status: 2, start_date: (DateTime.now - 5.years)..end_date, end_date: start_date..(DateTime.now + 5.years)).any?
      errors.add(:start_date, 'There is already a reservation that overlaps these dates')
      errors.add(:end_date, 'There is already a reservation that overlaps these dates')
    end

  end

end
