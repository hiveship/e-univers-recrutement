class UserController < ApplicationController
  # Controller qui ne gère que l'utilisateur connecté (@me)

  before_filter :require_login
  layout :set_layout

  def edit
    @user = @me
  end

  def update
    @user = @me
    @user.update_password params[:user][:pass]
    if  @user.save
      flash[:success] = "Votre mot de passe a bien été modifié !"
      redirect_to edit_user_path(@me)
    else
      flash[:success] = "Désolé, une erreur est survenue."
      redirect_to edit_user_path(@me)
    end
  end


end
