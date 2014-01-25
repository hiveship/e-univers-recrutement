class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :require_login, :except => [:auth]

  def require_login
    if session[:me]
      @me = User.find(session[:me])
      if @me.state == User::DEACTIVATE
        flash[:error] = "Erreur, votre compte est désactivé. Veuillez contacter un adminisateur."
        redirect_to :login

      end
    else
      redirect_to :login
    end
  end

  def have_admin_rights
    if  @me.status != User::ADMIN
      flash[:error] = "Erreur, cette page est réservée aux administrateurs."
      redirect_to :sessions
    end
  end

end
