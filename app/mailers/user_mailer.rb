class UserMailer < ActionMailer::Base
  default from: "projet.test.univers@gmail.com"

  def welcome(user)
    @user = user
    mail(to: @user.mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers créé')
  end

  def reset_password(user, new_password)
    @user = user
    mail(to: @user.mail, subject: 'Mot de passe sur la plate-forme de recrutement de E-Univers re-initialisé')
  end

  def set_admin(user)
    @user = user
    mail(to: @user.mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers promu administrateur')
  end

  def set_recruteur(user)
    @user = user
    mail(to: @user.mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers promu recruteur')
  end

  def activate(user)
    @user = user
    mail(to: @user.mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers activé')
  end

  def deactivate(user)
    @user = user
    mail(to: @user.mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers désactivé')
  end

  def destroy(user)
    @user = user
    mail(to: @user.mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers supprimer')
  end
end
