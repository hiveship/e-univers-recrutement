class Recruteur::CandidaturesController < Recruteur::RecruteurController

  def index
    # On trouve la session actuelle et on y recherche ses candidatures
    @session = Session.find(params[:id])
    @candidatures = Candidature.where(session_id: @session.id)
  end

  def show
    set_candidature
  end

  def set_result
    set_candidature
    @session = Session.find(@candidature.session_id)

    # Vérifier si la personne est bien un ADMIN ou MANAGER
    if @me.status != User::ADMIN and @me.status != User::MANAGER
      flash[:error] = "Vous n'êtes pas autorisé à faire cette action status = #{@me.status}"

      # Suivant le résultat de base de la candidature, certaines actions sont possibles
    elsif @candidature.result == Candidature::INDEFINI

      if params[:candidature][:result] == Candidature::ENTRETIEN
        @candidature.update(result: Candidature::ENTRETIEN)
        CandidatureMailer.interview(@candidature).deliver
        flash[:success] = "La demande d'entretien a bien été envoyée"

      elsif params[:candidature][:result] == Candidature::ACCEPTER
        @candidature.update(result: Candidature::ACCEPTER)
        CandidatureMailer.accepted(@candidature).deliver
        flash[:success] = "La candidature a bien été retenue"

      elsif params[:candidature][:result] == Candidature::REFUSER
        @candidature.update(result: Candidature::REFUSER)
        CandidatureMailer.decline(@candidature).deliver
        flash[:success] = "La candidature a bien été refusée"

      else
        flash[:error] = "L'action demandée n'est pas disponnible (1)"
      end


    elsif @candidature.result == Candidature::ENTRETIEN

      if params[:candidature][:result] == Candidature::ACCEPTER
        @candidature.update(result: Candidature::ACCEPTER)
        CandidatureMailer.accepted(@candidature).deliver
        flash[:success] = "La candidature a bien été retenue"

      elsif params[:candidature][:result] == Candidature::REFUSER
        @candidature.update(result: Candidature::REFUSER)
        CandidatureMailer.decline(@candidature).deliver
        flash[:success] = "La candidature a bien été refusée"

      else
        flash[:error] = "L'action demandée n'est pas disponnible (2)"
      end
    end

    # La vérification que la candidature est cloturé se fait dans le controleur evaluation avec la méthode candidature_close

    redirect_to recruteur_candidatures_path(@session.id)
  end

  private

  def set_candidature
    @candidature = Candidature.find_by(delete_string: params[:id])
  end
end