class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.user_mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers créé')
  end

  def reset_password_email(user, new_password)
    @user = user
    @new_password = new_password
    mail(to: @user.user_mail, subject: 'Mot de passe sur la plate-forme de recrutement de E-Univers re-initialisé')
  end

  def set_admin_mail(user)
    @user = user
    mail(to: @user.user_mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers promu administrateur')
  end

  def set_recruteur_mail(user)
    @user = user
    mail(to: @user.user_mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers promu recruteur')
  end

  def activate_mail(user)
    @user = user
    mail(to: @user.user_mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers activé')
  end

  def deactivate_mail(user)
    @user = user
    mail(to: @user.user_mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers désactivé')
  end

  def destroy_user_mail(user)
    @user = user
    mail(to: @user.user_mail, subject: 'Compte sur la plate-forme de recrutement de E-Univers supprimer')
  end
end
