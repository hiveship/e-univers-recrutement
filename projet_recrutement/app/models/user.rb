class User < ActiveRecord::Base
  validates_format_of :user_mail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_format_of :user_mail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :update
  validates_uniqueness_of :user_mail, :user_login
  validates :user_status, :inclusion => {:in => 1..2}
  validates :user_state, :inclusion => {:in => 1..2}
  validates :user_pass, :length => 4..200
  validates :user_login, :length => 3..10

  before_create do
    self.user_pass = User.hash_password(self.user_pass)
  end

  before_update do
    self.user_pass = User.hash_password(self.user_pass)
  end

  def self.identifiate(login,password)
    @me = User.where(user_pass: login[:user_login], user_pass: User.hash_password(password[:user_pass])).first!
  end

  def self.hash_password(password)
    Digest::SHA512.hexdigest(password)
  end

  def self.generate_random_password
    return SecureRandom.hex
  end

  def reset_user_password
    @new_password = User.generate_random_password
    self.update_columns(:user_pass => User.hash_password(@new_password))
    return @new_password
  end

  def activate
    self.update_columns(:user_state => 1)
  end

  def deactivate
    self.update_columns(:user_state => 2)
  end

  def set_admin
    self.update_columns(:user_status => 1)
  end

  def set_recruteur
    self.update_columns(:user_status => 2)
  end

end

