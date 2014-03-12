class CandidatureMailer < ActionMailer::Base
  default from: "projet.test.univers@gmail.com"

  def create(candidature)
  	@candidature = candidature
  	mail(to: @candidature.mail, subject: 'Candidature E-Univers enregistrée')
  end

  def destroy(candidature)
  	@candidature = candidature
  	mail(to: @candidature.mail, subject: 'Candidature supprimée sur E-Univers')
  end

  def interview(candidature)
  	@candidature = candidature
  	mail(to: @candidature.mail, subject: 'Entretien pour la candidature sur E-Univers')
  end

  def accepted(candidature)
  	@candidature = candidature
  	mail(to: @candidature.mail, subject: 'Candidature acceptée sur E-Univers')
  end

  def decline(candidature)
  	@candidature = candidature
  	mail(to: @candidature.mail, subject: 'Candidature refusée sur E-Univers')
  end

end
