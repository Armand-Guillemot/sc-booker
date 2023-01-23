class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property
  validate :date_range_property
  validate :date_range_user


  def date_range_property

    if property.reservations.where.not(id: id).where.not(status:0).where(start_date: (DateTime.now - 5.years)..end_date, end_date: start_date..(DateTime.now + 5.years)).any?
      errors.add(:start_date, 'There already is an approved property reservation that overlaps these dates')
      errors.add(:end_date, 'There already is an approved property reservation that overlaps these dates')
    end

  end


  def date_range_user

    if user.reservations.where.not(id: id).where.not(status:0).where(start_date: (DateTime.now - 5.years)..end_date, end_date: start_date..(DateTime.now + 5.years)).any?
      errors.add(:start_date, 'You already have an approved reservation that overlaps these dates')
      errors.add(:end_date, 'You already have an approved reservation that overlaps these dates')
    end

  end


end
