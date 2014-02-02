class UserController < ApplicationController
  # Controler qui gère uniquement @me
  def index
    @user = @me
  end

  def show
    @user = @me
  end

  def edit
    @user = @me
  end

  def update
    @user = @µe
    @user.update_password params[:pass]
    respond_to do |format|
      if  @user.save
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
