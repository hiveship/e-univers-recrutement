class Admin::EvaluationsController < Admin::AdminController

  def destroy
    @evaluation = Evaluation.find_by(id: params[:id])
    @candidature = Candidature.find_by(id: @evaluation.candidature_id)

    if @evaluation.destroy!
      flash[:success] = "Évaluation bien supprimée"
    else
      flash[:error] = "Impossible de supprimer l'évaluation"
    end

    redirect_to recruteur_evaluations_path(@candidature.delete_string)

  end

end