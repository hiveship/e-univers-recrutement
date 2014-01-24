class SiteController < ApplicationController

  def auth
    login = params[:login]
    password = params[:pass]
    @me = User.identifiate(login,password)
    if @me
      session[:me_id] = @me.id
      session[:me_state] = @me.state
      session[:me_status] = @me.status
      flash[:success] = "Authentification réussie !"
      redirect_to :users #redirige vers :users pour les tests
    end
  rescue
    flash[:error] = "Erreur d'authentification"
    redirect_to :login
  end

  def logout
    session.clear
    redirect_to root_path
  end

end
