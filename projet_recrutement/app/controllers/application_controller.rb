class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_login
    if session[:me_id]
      if session[:me_state]
        @me = User.find(session[:me_id])
      else
        flash[:error] = "Erreur, votre compte est désactivé. Veuillez contacter un adminisateur."
        redirect_to :login
      end
    else
      redirect_to :login
    end
  end

  def is_admin
    #status = 1 => administrateur --- status = 2 => recruteur
    if session[:me_status] != 1
      flash[:error] = "Erreur, cette page est réservée aux administrateurs"
      redirect_to :login
    end
  end

end

