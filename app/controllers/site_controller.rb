class SiteController < ApplicationController
  skip_before_filter :require_login, only:[:login, :auth]

  def auth
    login = params[:login]
    password = params[:pass]
    @me = User.where(login: login[:login], pass: User.hash_password(password[:pass])).first!
    if @me
      session[:me] = @me.id
      flash[:success] = "Authentification réussie !"
      if @me.status == User::MANAGER
        redirect_to recruteur_sessions_url
      else
        redirect_to [ @me.status,:sessions ] # avec @me.status = "admin" ou "recruteur" -> directement dans l URL
      end
    end
  rescue
    flash[:error] = "Erreur d'authentification."
    redirect_to :login
  end

  def logout
    session.clear
    flash[:success] = "Vous êtes bien déconnecté. "
    redirect_to root_path
  end

end
