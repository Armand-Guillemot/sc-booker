class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :reservations

  validates :email, :first_name, :email, presence: true

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
        result += result_array
      end
    end
    return result.uniq
  end
end
