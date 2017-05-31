class ErrorsMailer < ActionMailer::Base
  default from: 'noreply@spiderpolicy.com'

  def notify_admin(recipient, message)
    mail(to: recipient, subject: 'Error Occurred on Spider Policy', body: message)
  end
end
