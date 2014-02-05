class SessionMailer < ActionMailer::Base
  default from: "projet.test.univers@gmail.com"

  def cancel(candidature)
    @candidature = candidature
    mail(to: @candidature.mail, subject: 'Session de recrutement annulée')
  end
end
