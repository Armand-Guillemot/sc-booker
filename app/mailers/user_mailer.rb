class UserMailer < ApplicationMailer
    default from: 'noreply.scbooker@gmail.com'

    def new_reservation(reservation)
        @reservation = reservation
        @user = reservation.user
        @property = reservation.property
        mail(to: User.where(admin: true).pluck(:email), subject: "🔔 Reservation made by #{@user.first_name} for #{@property.name}")
    end

    def approved_reservation(reservation)
        @reservation = reservation
        @user = reservation.user
        @property = reservation.property
        mail(to: @user.email, subject: "✅ Your Reservation for #{@property.name} is Approved")
    end

    def declined_reservation(reservation)
        @reservation = reservation
        @user = reservation.user
        @property = reservation.property
        mail(to: @user.email, subject: "❌ Your Reservation for #{@property.name} is Declined")
    end

end
