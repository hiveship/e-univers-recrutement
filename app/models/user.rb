class User < ActiveRecord::Base
  ADMIN = "admin"
  RECRUTEUR = "recruteur"
  MANAGER = "manager"

  ACTIVATE = "active"
  DEACTIVATE = "blocked"

  validates_presence_of :mail, :login, :status, :state, :pass
  validates_uniqueness_of :mail, :login
  validates :login, :length => 3..10

  has_many :evaluations

  before_create do
    # Actions éxécutées au moment de l'enregistrement dans la BDD : hash du mdp et mise en minuscule du pseudo
    self.pass = User.hash_password(self.pass)
    self.login = self.login.downcase
  end

  def self.hash_password(password)
    Digest::SHA512.hexdigest(password)
  end

  def self.generate_random_password
    SecureRandom.hex
  end

  def update_password(password)
    update_columns(:pass => User.hash_password(password))
  end

  def reset_password
    new_password = User.generate_random_password
    update_password(new_password)
    new_password
  end

end
