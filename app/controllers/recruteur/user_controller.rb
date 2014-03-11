class Recruteur::UserController < Recruteur::RecruteurController
  # Controler qui gère uniquement @me

  def edit
    @user = @me
  end

  def update
    @user = @me
    @user.update_password params[:user][:pass]

    if @user.save
      flash[:success] = "Votre mot de passe a bien été modifié !"
      redirect_to edit_recruteur_user_path(@me)
    else
      flash[:error] = "Modification impossible"
      redirect_to edit_recruteur_user_path(@me)
    end
  end
end
