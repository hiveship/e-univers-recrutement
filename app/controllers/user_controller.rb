class UserController < ApplicationController
  # Controller qui ne gère que l'utilisateur connecté (@me)

  before_filter :require_login
  before_action :set_layout

  def set_layout
    if @me.status == User::RECRUTEUR || @me.status == User::MANAGER
     render layout: "recruteur"
    else
     render layout: "admin"
    end
  end

  def edit
    @user = @me
  end

  def update
    @user = @me
    @user.update_password params[@me.login][:pass]
    respond_to do |format|
      if  @user.save
        flash[:success] = "Votre mot de passe a bien été modifié !"
        redirect_to root_path
      else
        flash[:warning] = "pb!"
        redirect_to root_path
      end
      render 'edit'
    end
  end


end
