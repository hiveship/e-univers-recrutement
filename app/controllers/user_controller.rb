class UserController < ApplicationController
  # Controler qui gère uniquement @me

  def edit
    @user = @me
  end

  def update
    @user = @me
    @user.update_password params[:user][:pass]
    respond_to do |format|
      if  @user.save
        flash[:success] = "Votre mot de passe a bien été modifié !"
        format.html { redirect_to edit_user_path}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
