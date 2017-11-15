class UserMailer < ApplicationMailer
  default from: 'warsztaty@infakt.pl'
  layout 'mailer'

  def confirm_email(user, email)
    @user = user

    mail(to: email, subject: "Potwierdź adres email")
  end
end
