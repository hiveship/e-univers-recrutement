class User < ActiveRecord::Base
  ADMIN = "administrator"
  RECRUTEUR = "recruiter"
  ACTIVATE = "active"
  DEACTIVATE = "blocked"

  validates_uniqueness_of :mail, :login
  validates :login, :length => 3..10

  # has_many :evaluations

  before_create do
    self.pass = User.hash_password(self.pass)
  end

  def self.hash_password(password)
    Digest::SHA512.hexdigest(password)
  end

  def self.generate_random_password
    SecureRandom.hex
  end

  def update_password(password)
    test = User.hash_password(password)
    self.update_columns(:pass => test)
  end

  def self.reset_password
    new_password = generate_random_password
    self.update_password(new_password)
    new_password
  end

end
