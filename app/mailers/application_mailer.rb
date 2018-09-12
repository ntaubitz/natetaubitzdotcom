class ApplicationMailer < ActionMailer::Base
  default from: 'ntaubitz@gmail.com'
  layout 'mailer'

  def contact_email(email, note)
    body = "from #{email}, #{note}"
    mail(to: 'ntaubitz@gmail.com', subject: 'natetaubitz.us contact', body: body).deliver
  end

  def password_changed(user)
    body = <<BODY
      Your password was changed. If you did not access https://natetaubitz.us and change your password
      please contact ntaubitz@gmail.com.

      Thanks!

      Nate
BODY
    mail(to: user.email, subject: 'natetaubitz.us password change', body: body).deliver
  end
end
