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
    @user.update_password params[:user][:pass]
    respond_to do |format|
      if  @user.save
        flash[:success] = "Votre mot de passe a bien été modifié !"
        format.html { redirect_to edit_user_path(@me) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
