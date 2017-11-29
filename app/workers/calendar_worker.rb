class CalendarWorker
  include Sidekiq::Worker

  def perform(reservation_id)
    reservation = Reservation.find_by(id: reservation_id)
    UserCalendarNotifier.new(reservation.user).perform(reservation) if reservation
    true
  end
end
