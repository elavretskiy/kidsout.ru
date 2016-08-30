class NotificationMailer < ActionMailer::Base
  def notify(sender, recipient)
    @sender = sender
    mail(to: recipient, subject: "Новое сообщение от #{@sender}")
  end
end
