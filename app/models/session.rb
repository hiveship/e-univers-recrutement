class Session < ActiveRecord::Base
  ACTIVATE = "active"
  DEACTIVATE = "blocked"

  validates_presence_of :description, :title, :endDate, :beginDate
  validates :title, :length => 1..30
  validate :validate_end_date, :validate_begin_date

  belongs_to :profil
  has_many :candidatures

  def validate_end_date
    if endDate < Date.today
      errors.add(:endDate, "Erreur, la date de fin ne peux être inférieur à la date du jour")
    end
    if endDate < beginDate
      errors.add(:endDate, "Erreur, la date de fin ne peut être inféieur à la date de début")
    end
  end

  def validate_begin_date
    if beginDate < Date.today
      errors.add(:beginDate, "Erreur, la date de début doit au moins être celle d'aujourd'hui.")
    end
    if beginDate > endDate
      errors.add(:beginDate, "Erreur, la date de début ne peux être supérieure à la date de fin.")
    end
  end

  def get_status
    # Calcul et retourne le statut d'une session [en cours / prévu / terminée]
    if self.beginDate > Date.today
      :planned
    elsif self.endDate < Date.today
      :closed
    else
      :pending
    end
  end
end
