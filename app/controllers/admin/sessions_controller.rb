class Admin::SessionsController < Admin::AdminController

  def index
    @sessions = Session.all
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
    respond_to do |format|
      if @session.save
        flash[:success] = "La session a bien été créée !"
        format.html { redirect_to admin_sessions_path}
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @session = Session.find params[:id]
    respond_to do |format|
      if @session.update params.require(:session).permit(:title, :description, :beginDate, :endDate)
        flash[:success] = "La session a bien été modifiée !"
        format.html { redirect_to admin_sessions_path }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Session.find(params[:id]).destroy!
    flash[:success]=" La session a bien été supprimée !"
    respond_to do |format|
      format.html { redirect_to admin_sessions_path }
      format.json { head :no_content }
    end

  end


  def activate
    @session = Session.find params[:id]
    if @session.state == Session::DEACTIVATE
      @session.update_columns :state => Session::ACTIVATE
      flash[:success] = "La session a bien été relancée !"
    else
      flash[:error] = "La session est déjà actif !"
    end
    redirect_to admin_sessions_path
  end

  def deactivate
    @session = Session.find params[:id]
    if @session.state == Session::ACTIVATE
      @session.update_columns :state => Session::DEACTIVATE
      flash[:success] = "La session a bien été bloqué !"
    else
      flash[:error] = "La session est déjà bloquée !"
    end
    redirect_to admin_sessions_path
  end
end
