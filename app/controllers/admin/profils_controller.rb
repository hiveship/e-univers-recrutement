class Admin::ProfilsController < Admin::AdminController

  def index
    @profils = Profil.all
  end

  def new
    @profil = Profil.new
  end

  def edit
    @profil = Profil.find(params[:id])
  end

  def create
    @profil = Profil.new params.require(:profil).permit(:title, :description)
    respond_to do |format|
      if @profil.save
        flash[:success] = "Profil de poste créé avec succès !"
        format.html { redirect_to admin_profils_path}
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @profil.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @profil = Profil.find(params[:id])
    respond_to do |format|
      if @profil.update params.require(:profil).permit(:title, :description)
        flash[:success] = "Le profil de poste a bien été modifié !"
        format.html { redirect_to admin_profils_path }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profil.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profil = Profil.find params[:id]
    if @profil.sessions.empty?
      @profil.destroy!
      flash[:success] = "Le profil de poste a bien été supprimé !"
      redirect_to admin_profils_path
    else
      flash[:error] = "Ce profil de poste est lié à au moins une session de recrutement !"
      redirect_to admin_profils_path
    end
  end

end
