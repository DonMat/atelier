class ReservationMailer < ApplicationMailer

  def take(reservation)
    @reservation = reservation
    @book = reservation.book
    @user = reservation.user
    return if @book.blank? or @user.blank?

    mail(to: @user.email, subject: "Wypożyczyłeś książkę: #{@book.title}")
  end
end
