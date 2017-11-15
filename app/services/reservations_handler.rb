class ReservationsHandler
  def initialize(user)
    @user = user
  end

  def take(book)
    return unless can_take?(book)

    if available_reservation(book).present?
      reservation = available_reservation(book)
      reservation.update_attributes(status: 'TAKEN')
    else
      reservation = book.reservations.create(user: user, status: 'TAKEN')
    end
    ReservationMailer.take(reservation).deliver_now
  end

  def can_take?(book)
    not_taken?(book) && ( available_for_user?(book) || book.reservations.empty? )
  end

  def can_give_back?(book)
    book.reservations.find_by(user: user, status: 'TAKEN').present?
  end

  def give_back(book)
    return unless can_give_back?(book)
    ActiveRecord::Base.transaction do
      book.reservations.find_by(status: 'TAKEN').update_attributes(status: 'RETURNED')
      next_in_queue.update_attributes(status: 'AVAILABLE') if next_in_queue(book).present?
    end
  end

  def can_reserve?(book)
    book.reservations.find_by(user: user, status: 'RESERVED').nil?
  end

  def reserve(book)
    return unless can_reserve?(book)

    book.reservations.create(user: user, status: 'RESERVED')
  end

  def cancel_reservation(book)
    book.reservations.where(user: user, status: 'RESERVED').order(created_at: :asc).first.update_attributes(status: 'CANCELED')
  end

  private
  attr_reader :user

  def not_taken?(book)
    book.reservations.find_by(status: 'TAKEN').nil?
  end

  def available_for_user?(book)
    if available_reservation(book).present?
      available_reservation(book).user == user
    else
      pending_reservations(book).nil?
    end
  end

  def pending_reservations(book)
    book.reservations.find_by(status: 'PENDING')
  end

  def available_reservation(book)
    book.reservations.find_by(status: 'AVAILABLE')
  end

  def next_in_queue(book)
    book.reservations.where(status: 'RESERVED').order(created_at: :asc).first
  end
end
