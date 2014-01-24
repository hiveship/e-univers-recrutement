class SiteController < ApplicationController
  skip_before_filter :require_login, only: %i(login auth)

  def auth
    login = params[:login]
    password = params[:pass]
   @me = User.where(user_pass: login[:user_login], user_pass: User.hash_password(password[:user_pass])).first!
    if @me
      session[:me] = @me.id
      flash[:success] = "Authentification réussie !"
      redirect_to :users #redirige vers :users pour les tests
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
