class User < ActiveRecord::Base
  ADMIN = "administrator"
  RECRUTEUR = "recruiter"
  ACTIVATE = "active"
  DEACTIVATE = "blocked"

  validates_format_of :login, :with => [A-Za-z0-9]
  validates_uniqueness_of :user_mail, :user_login
  validates :user_login, :length => 3..10

  #has_many :evaluations

  def self.hash_password(password)
    Digest::SHA512.hexdigest(password)
  end

  def self.generate_random_password
     SecureRandom.hex
  end

  def self.update_password(password)
    self.update_columns pass: User.has_password(password)
  end

  def self.reset_password
    new_password = SecureRandom.hex
    update_password new_password
    new_password
  end

end
