class Recruteur::SessionsController < Recruteur::RecruteurController

  def index
    if @me.status == User::ADMIN
      @sessions = Session.all
    else
      # Les managers et recruteurs ne voient que les sessions en cours
      @sessions = Session.where("beginDate <= :today and state = :activate", {today: Date.today, activate: Session::ACTIVATE})
    end
  end

end
