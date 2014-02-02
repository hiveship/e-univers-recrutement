class Admin::UsersController < Admin::AdminController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.new params.require(:user).permit(:login, :mail, :status)
    @user.pass = User.generate_random_password
    password = @user.pass
    @user.state = User::ACTIVATE
    respond_to do |format|
      if @user.save
        UserMailer.welcome(@user, password).deliver
        flash[:success] = "L'utilisateur a bien été créé !"
        format.html { redirect_to admin_users_path}
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find params[:id]
    respond_to do |format|
      if  @user.update params.require(:user).permit(:login, :mail)
        flash[:success] = "L'utilisateur a bien été modifié !"
        format.html { redirect_to admin_users_path}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find params[:id]
    if @user.id != @me.id
      @user.destroy
      flash[:success] = "L'utilisateur a bien été supprimé !"
      respond_to do |format|
        format.html { redirect_to admin_users_path }
        format.json { head :no_content }
      end
    else
      flash[:error] = "Erreur, vous ne pouvez pas supprimer votre propre compte"
      redirect_to :admin_users
    end
  end

  def activate
    @user = User.find params[:id]
    if @user.id != @me.id
      if @user.state == User::DEACTIVATE
        @user.update_columns :state => User::ACTIVATE
        UserMailer.activate(@user).deliver
        flash[:success] = "Le compte a bien été bloqué !"
      else
        flash[:error] = "Le compte est déjà actif !"
      end
    else
      flash[:error] = "Vous ne pouvez pas désactiver votre propre compte !"
    end
    redirect_to :admin_users
  end

  def deactivate
    @user = User.find params[:id]
    if @user.id != @me.id
      if @user.state == User::ACTIVATE
        @user.update_columns :state => User::DEACTIVATE
        UserMailer.deactivate(@user).deliver
        flash[:success] = "Le compte a bien été activé !"
      else
        flash[:error] = "le compte est déjà bloqué !"
      end
    else
      flash[:error] = "Vous ne pouvez pas désactiver votre propre compte !"
    end
    redirect_to :admin_users
  end

  def set_admin
    @user = User.find params[:id]
    if  @user.id != @me.id
      if @user.status == User::RECRUTEUR
        @user.update_columns :status => User::ADMIN
        UserMailer.set_admin(@user).deliver
        flash[:success] = "Le compte a bien été nommé administrateur !"
      else
        flash[:error] = "Erreur, il s'agit déjà d'un administrateur !"
      end
    else
      flash[:error] = "Erreur, vous ne pouvez pas changer le statut de votre propre compte !"
    end
    redirect_to :admin_users
  end

  def set_recruteur
    @user = User.find params[:id]
    if  @user.id != @me.id
      if @user.status == User::ADMIN
        @user.update_columns :status => User::RECRUTEUR
        UserMailer.set_recruteur(@user).deliver
        flash[:success] = "Le compte a bien été nommé recruteur !"
      else
        flash[:error] = "Erreur, il s'agit déjà d'un recruteur !"
      end
    else
      flash[:error] = "Erreur, vous ne pouvez pas changer le statut de votre propre compte !"
    end
    redirect_to :admin_users
  end

  def reset_password
    @user = User.find params[:id]
    new_password = @user.reset_password
    UserMailer.reset_password(@user, new_password).deliver
    flash[:success] = "Le mot de passse a bien été ré-initialisé !"
    redirect_to :admin_users
  end

end
