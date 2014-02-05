class SessionsController < ApplicationController

  def index
    # Affichage uniquement des sessions en cours et non suspendues
    @sessions = Session.where("beginDate <= :today and endDate >= :today and state = :activate", { today: Date.today, activate: Session::ACTIVATE })
  end

  def show
    @session = Session.find params[:id]
  end

end
