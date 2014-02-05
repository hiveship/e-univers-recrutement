class Profil < ActiveRecord::Base

  validates_presence_of :description, :title
  validates :title, :length => 3..30

  has_many :sessions

end
