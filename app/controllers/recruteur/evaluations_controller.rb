class Recruteur::EvaluationsController < Recruteur::RecruteurController
  before_action :candidature_close, only: [:new, :create] # Si la candidature est close on ne peux plus que les voir
  before_action :candidature_close_with_eval, only: [:edit, :update, :destroy]

  def index
    set_candidature
    # Récupération de toutes les évaluations d'une session
    @evaluations = Evaluation.where(candidature_id: @candidature.id)
    @evaluation = Evaluation.new
     @myeval = Evaluation.where(candidature_id: @candidature,user_id: @me).first
    # @myeval = Evaluation.find(candidature_id: @candidature,user_id: @me)
  end

  def show
    set_evaluation
    set_candidature_eval
    flash[:success] = "#{@candidature.id}"
    redirect_to recruteur_evaluations_path(@candidature.id)
  end

  def new
    set_candidature

    # Si une évaluation a déjà été faire par cette utilisateur alors refus
    if Evaluation.find_by(user_id: @me.id, candidature_id: @candidature.id)
      flash[:error] = "Vous avez déjà évalué cette candidature"
      redirect_to recruteur_evaluations_path(@candidature.delete_string)
    end

    @evaluation = Evaluation.new
  end

  def edit
    set_evaluation
    set_candidature_eval
    # Si l'évaluation que l'on tente de modifier n'est pas la notre, refus
    if @evaluation.user_id != @me.id
      flash[:error] = "Vous ne pouvez modifier les candidatures des autres cand = #{@candidature.id} eval = #{@evaluation.id}"
      redirect_to recruteur_evaluations_path(@candidature.delete_string)
    end
  end

  def create
    set_candidature # Permet de connaître la candidature en cours

    # Si une évaluation a déjà été faire par cette utilisateur alors refus
    if Evaluation.find_by(user_id: @me.id, id: @candidature.id)
      flash[:error] = "Vous avez déjà évalué cette candidature"
      redirect_to recruteur_evaluations_path(@candidature.delete_string)
    end

    @evaluation = Evaluation.new params.require(:evaluation).permit(:mark, :commentary)
    @evaluation.candidature_id = @candidature.id
    @evaluation.user_id = @me.id

    if @evaluation.save
      flash[:success] = "Votre évaluation a bien été enregistrée !"
      redirect_to recruteur_evaluations_path
    else
      redirect_to new_recruteur_evaluation_path(@candidature.delete_string)
    end
  end

  def update
    set_evaluation
    set_candidature_eval

    # Si l'évaluation que l'on tente de modifier n'est pas la notre, refus
    if @evaluation.user_id != @me.id
      flash[:error] = "Vous ne pouvez modifier les candidatures des autres"
      redirect_to recruteur_evaluation_path
    end

    if @evaluation.update params.require(:evaluation).permit(:mark, :commentary)
      flash[:success] = "La modification a bien été éffectuée"
      redirect_to recruteur_evaluations_path(@candidature.delete_string)
    else
      flash[:error] = "Impossible de modifier l'évaluation."
      redirect_to edit_recruteur_evaluation_path
    end
  end

  def destroy
    set_evaluation
    set_candidature_eval
    # Si l'évaluation que l'on tente de supprimer n'est pas la notre, refus
    if @evaluation.user_id != @me.id
      flash[:error] = "Vous ne pouvez supprimer les candidatures des autres"
      redirect_to recruteur_evaluations_path(@candidature.delete_string)
    end

    if @evaluation.destroy!
      flash[:success] = "Évaluation bien supprimée"
    else
      flash[:error] = "Impossible de supprimer l'évaluation"
    end
    redirect_to recruteur_evaluations_path(@candidature.delete_string)
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_evaluation
    @evaluation = Evaluation.find_by(id: params[:id])
  end

# Permet de connaître la candidature en cours
  def set_candidature
    @candidature = Candidature.find_by(delete_string: params[:id])
  end

# Permet de connaître la candidature de l'évaluation en cours
  def set_candidature_eval
    set_evaluation
    @candidature = Candidature.find_by(id: @evaluation.candidature_id)
  end

# Vérifier si la candidature est clotuée
  def candidature_close
    set_candidature
    if @candidature.is_close
      flash[:error] = "La candidature est cloturée"
      redirect_to recruteur_evaluations_path(@candidature.delete_string)
    end
  end

# Vérifie si la candidature est close à partir d'une évaluation car l'id de la candidature n'est pas accessible par l'url
  def candidature_close_with_eval
    set_candidature_eval
    if @candidature.is_close
      flash[:error] = "La candidature est cloturée"
      redirect_to recruteur_evaluations_path(@candidature.delete_string)
    end
  end
end