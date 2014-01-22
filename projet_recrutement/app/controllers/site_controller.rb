class SiteController < ApplicationController

  def auth
      login = params[:user_login]
      password = params[:user_pass]
      @me = User.identifiate(login,password)
      if @me
        session[:me_id] = @me.id
        session[:me_state] = @me.user_state
        session[:me_status] = @me.user_status
        flash[:success] = "Authentification réussie !"
        redirect_to :sessions
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

