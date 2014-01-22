class UsersController < ApplicationController
  before_filter :is_admin
  before_filter :require_login
  before_action :set_user, only: [:show, :edit, :update, :destroy, :activate_user, :deactivate_user, :reset_user_password, :set_admin, :set_recruteur]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new params.require(:user).permit(:user_login, :user_mail, :user_status)
    @user.user_pass = User.generate_random_password
    ## Il faudra envoyer ici à l'utilisateur
    flash[:test] = @user.user_pass
    @user.user_state = 1
    UserMailer.welcome_email(@user).deliver
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Utilisateur créé avec succès' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @user.update params.require(:user).permit(:user_login, :user_mail, :user_pass)
        format.html { redirect_to @user, notice: 'Utilisateur créé avec succès.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @user.id != session[:me_id]
      UserMailer.destroy_user_mail(@user).deliver
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    else
      flash[:error] = "Erreur, vous ne pouvez pas supprimer votre propre compte"
      redirect_to :users
    end
  end

  def activate_user
    if @user.user_state == 2
      @user.activate
      UserMailer.activate_mail(@user).deliver
      flash[:success] = "Le compte a bien été activé !"
    else
      flash[:error] = "Erreur, ce compte est déjà actif"
    end
    redirect_to :users
  end

  def deactivate_user
    if @user.id != session[:me_id]
      if @user.user_state == 1
        @user.deactivate
        UserMailer.deactivate_mail(@user).deliver
        flash[:success] = "Le compte a bien été désactivé !"
      else
        flash[:error] = "Erreur, ce compte est déjà désactivé"
      end
    else
      flash[:error] = "Erreur, vous ne pouvez pas désactiver votre propre compte"
    end
    redirect_to :users
  end

  def set_admin
    if @user.id != session[:me_id]
      if @user.user_status == 2
        @user.set_admin
        UserMailer.set_admin_mail(@user).deliver
        flash[:success] = "L'utilisateur a bien été nommé administrateur"
      end
    end
    redirect_to :users
  end

  def set_recruteur
    if @user.id != session[:me_id]
      if @user.user_status == 1
        @user.set_recruteur
        UserMailer.set_recruteur_mail(@user).deliver
        flash[:success] = "L'utilisateur a bien été nommé recruteur"
      else
        flash[:error] = "Ce compte est déjà recruteur."
      end
    else
      flash[:error] = "Vous ne pouvez pas changer le status de votre propre compte."
    end
    redirect_to :users
  end

  def reset_user_password
    @new_password = @user.reset_user_password
    UserMailer.reset_password_email(@user, @new_password).deliver
    flash[:success] = "Le mot de passse a bien été ré-initialisé."
    redirect_to :users
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
