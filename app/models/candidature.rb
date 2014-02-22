# string   "pseudo"
# string   "mail"
# string   "motivation"
# date     "submitDate"
# date     "bornDate"
# string   "result"
# integer  "session_id"
# datetime "created_at"
# datetime "updated_at"

class Candidature < ActiveRecord::Base
  # Constantes de l'attribut "result"
  INDEFINI = "undefined"
  ACCEPTER = "accepted"
  REFUSER = "decline"
  ENTRETIEN = "interview"

  belongs_to :session
  has_many :evaluation

  validates_presence_of :pseudo
  validates_length_of :pseudo, {in: 3..10}
  validates_presence_of :mail
  validates_presence_of :motivation
  validates_presence_of :submitDate
  validates_presence_of :bornDate
  validates_presence_of :result
  #validates_uniqueness_of :mail, :pseudo ,:session_id
  validate :valid_born_date


  # Vérification de la date de naissance
  def valid_born_date
    if (self.bornDate >= Date.today)
      return true
    else
      return false
    end
  end

  def is_close
    if self.result == Candidature::REFUSER or self.result == Candidature::ACCEPTER
      return true
    else
      return false
    end

  end
end