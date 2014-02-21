class SiteController < ApplicationController

  def auth
    login = params[:login]
    password = params[:pass]
    @me = User.where(login: login[:login], pass: User.hash_password(password[:pass])).first!
    if @me
      session[:me] = @me.id
      flash[:success] = "Authentification réussie !"
      redirect_to recruteur_sessions_url
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
