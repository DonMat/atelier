class NotificationEmailWorkerWorker
  include Sidekiq::Worker

  def perform(book_id)
    book = Book.find_by(id: book_id)
    if book
      ReservationMailer.book_return_remind(book).deliver
      ReservationMailer.book_reserved_return(book).deliver
    end
  end
end
