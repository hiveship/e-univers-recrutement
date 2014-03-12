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
    password = @user.pass # On récupère le password avant qu'il soit sécurisé, afin de pouvoir l'envoyer par mail
    flash[:success] = password # a retiré lors du déploiement
    @user.state = User::ACTIVATE

    if @user.save
      UserMailer.welcome(@user, password).deliver
       flash[:success] = "L'utilisateur a bien été créé !"
      redirect_to admin_users_path
    else
      flash[:error] = "Impossible de créer l'utilisateur"
      redirect_to new_admin_user_path
    end
  end

  def update
    @user = User.find params[:id]

    if  @user.update params.require(:user).permit(:login, :mail)
      flash[:success] = "L'utilisateur a bien été modifié !"
      redirect_to admin_users_path
    else
      flash[:error] = "Impossible de modifier l'utilisateur."
      redirect_to edit_admin_user_path
    end
  end

  def destroy
    @user = User.find params[:id]

    if @user.id != @me.id
      @user.destroy!
      flash[:success] = "L'utilisateur a bien été supprimé !"
      redirect_to admin_users_path
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
      if @user.status == User::RECRUTEUR || @user.status == User::MANAGER
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
      if @user.status == User::ADMIN || @user.status == User::MANAGER
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

  def set_manager
    @user = User.find params[:id]
    if  @user.id != @me.id
      if @user.status == User::ADMIN || @user.status == User::RECRUTEUR
        @user.update_columns :status => User::MANAGER
        UserMailer.set_manager(@user).deliver
        flash[:success] = "Le compte a bien été nommé manager !"
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
    flash[:success] = "Vous avez bien reintialisé le mot de passe"
    redirect_to :admin_users
  end

end
