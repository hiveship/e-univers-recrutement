class Session < ActiveRecord::Base
  PLANNED = "planned"
  CLOSED = "closed"
  PENDING = "pending"
  ACTIVATE = "active"
  DEACTIVATE = "blocked"

  validates_presence_of :description, :title, :endDate
  validates :title, :length => 1..50
  validate :validate_end_date, :validate_begin_date

  has_one :profil
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
    if self.beginDate > Date.today
      Session::PLANNED
    elsif self.endDate < Date.today
      Session::CLOSED
    else
      Session::PENDING
    end
  end

end
