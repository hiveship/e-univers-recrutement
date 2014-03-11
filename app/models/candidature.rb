class Candidature < ActiveRecord::Base
  # Constantes de l'attribut "result"
  INDEFINI = "undefined"
  ACCEPTER = "accepted"
  REFUSER = "decline"
  ENTRETIEN = "interview"

  validates_presence_of :pseudo, :mail, :motivation, :submitDate, :bornDate, :result
  validates_length_of :pseudo, {in: 3..10}
  validate :is_unique
  validate :valid_born_date

  belongs_to :sessions
  has_many :evaluation

  # La date de naissance doit être strictement supérieur à la date du jour
  def valid_born_date
    if self.bornDate > Date.today
    end
  end

  def is_close
    if self.result == Candidature::REFUSER or self.result == Candidature::ACCEPTER
    end
  end

  # Pour une session, on ne peut utiliser un mail ou un pseudo déjà utilisé
  def is_unique
    unless Candidature.exists?(session_id: self.session_id, pseudo: self.pseudo) or Candidature.exists?(session_id: self.session_id, mail: self.mail)
    end
  end

  def to_param
    #Permet de changer le paramètre principale (id) par un autre (ici delete_string)
    self.delete_string
  end

  def self.generate_random_string
    SecureRandom.hex(4)
  end

end