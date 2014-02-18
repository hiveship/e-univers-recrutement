class Recruteur::SessionsController < Recruteur::RecruteurController

  def index
    if @me.status==User::ADMIN
      @sessions = Session.all
    else
      @sessions = Session.where("beginDate <= :today and state = :activate", { today: Date.today, activate: Session::ACTIVATE })
    end
  end

end
