class Admin::CandidaturesController < Admin::AdminController

  def destroy
    @candidature = Candidature.find_by(delete_string: params[:id])

    # Lors de la suppression d'une candidature, toutes les évaluations liées sont également supprimées
    @candidature.evaluation.each do |evaluation|
      evaluation.destroy!
    end

    id = @candidature.session_id
    @candidature.destroy!
    flash[:success] = "La candidature a bien été supprimée"
    redirect_to recruteur_candidatures_path(id)

  end

end
