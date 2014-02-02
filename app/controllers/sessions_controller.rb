class SessionsController < ApplicationController

  def index
    # Affichage uniquement des sessions en cours
    @sessions = Session.where("beginDate >= :today and endDate <= :today", { today: Date.today })
  end

  def show
  end

end
