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

    if @profil.save
      flash[:success] = "Profil de poste créé avec succès !"
      redirect_to admin_profils_path
    else
      flash[:error] = "Impossible de créer le profil de poste."
      redirect_to new_admin_profil_path
    end
  end

  def update
    @profil = Profil.find(params[:id])

    if @profil.update params.require(:profil).permit(:title, :description)
      flash[:success] = "Le profil de poste a bien été modifié !"
    else
      flash[:error] = "Impossible de modifier le profil. Veuillez réesayer."
    end
    redirect_to admin_profils_path
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
