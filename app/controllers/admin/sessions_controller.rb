class Admin::SessionsController < Admin::AdminController

  def index
    @sessions= Session.all
  end

  def show
  end

  def new
    @session = Session.new
  end

  def edit
  end

  def create
    @session = Session.new params.require(:session).permit(:title, :description, :beginDate, :endDate, :profil_id)
    @session.state = Session::ACTIVATE

    if @session.save
      flash[:success] = "La session a bien été créée !"
      redirect_to recruteur_sessions_path
    else
      flash[:error] = "Impossible de créer la session."
      redirect_to new_admin_session_path
    end
  end

  def update
    @session = Session.find params[:id]

    if @session.update params.require(:session).permit(:title, :description, :beginDate, :endDate)
      flash[:success] = "La session a bien été modifiée !"
      redirect_to recruteur_sessions_path
    else
      redirect_to edit_admin_session_path
    end
  end

  def destroy
    Session.find(params[:id]).destroy!
    flash[:success] = " La session a bien été supprimée !"
    redirect_to recruteur_sessions_path
  end


  def activate
    @session = Session.find params[:id]

    if @session.state == Session::DEACTIVATE
      @session.update_columns :state => Session::ACTIVATE
      flash[:success] = "La session a bien été relancée !"
    else
      flash[:error] = "La session est déjà actif !"
    end
    redirect_to recruteur_sessions_path
  end

  def deactivate
    @session = Session.find params[:id]
    if @session.state == Session::ACTIVATE
      @session.update_columns :state => Session::DEACTIVATE
      flash[:success] = "La session a bien été bloqué !"
    else
      flash[:error] = "La session est déjà bloquée !"
    end
    redirect_to recruteur_sessions_path
  end
end
