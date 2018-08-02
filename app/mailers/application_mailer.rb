class ApplicationMailer < ActionMailer::Base
  default from: 'ntaubitz@gmail.com'
  layout 'mailer'

  def contact_email(email, note)
    body = "from #{email}, #{note}"
    mail(to: 'ntaubitz@gmail.com', subject: 'natetaubitz.us contact', body: body).deliver
  end
end
