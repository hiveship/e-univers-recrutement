class Recruteur::SessionsController < Recruteur::RecruteurController

  def index
    @sessions = Session.all
  end

end
