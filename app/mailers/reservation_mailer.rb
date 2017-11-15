class ReservationMailer < ApplicationMailer

  def take(reservation)
    @reservation = reservation
    @book = reservation.book
    @user = reservation.user
    return if @book.blank? or @user.blank?

    mail(to: @user.email, subject: "Wypożyczyłeś książkę: #{@book.title}")
  end

  def book_return_remind(book)
    @book = book
    @reservation = book.reservations.find_by(status: "TAKEN")
    @user = @reservation.user if @reservation
    return if @reservation.blank? or @user.blank?# or @reservation.expires_at < Time.now + 2.minutes #@reservation.expires_at.to_date < Date.tomorrow

    mail(to: @user.email, subject: "Upływa termin oddania książki pt. #{@book.title}")
  end

  def book_reserved_return(book)
    @book = book
    @reservation = book.reservations.find_by(status: "RESERVED")
    @user = @reservation.user if @reservation
    return if @reservation.blank? or @user.blank?

    mail(to: @user.email, subject: "Upływa termin ksiażki #{@book.title}, niedługo powinna zostać oddana")
  end
end
