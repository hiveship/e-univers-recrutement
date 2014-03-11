class CandidaturesController < ApplicationController
  before_action :set_candidature, only: [:show, :destroy]

  def show
  end

  def new
    @candidature = Candidature.new
  end

  def create
    @session = Session.find_by(id: params[:id])

    @candidature = Candidature.new(candidature_params)

    @candidature.delete_string = Candidature.generate_random_string
    # Le résultat de la candidature est indéfini à sa création
    @candidature.result = Candidature::INDEFINI
    @candidature.submitDate = Date.today
    @candidature.session_id = @session.id


    if !@candidature.is_unique
    flash[:error]= "Votre Email est deja enregistré pour cette session"
    redirect_to root_path
    end

    if !@candidature.valid_born_date
    flash[:error]= "La date de naissance n'est pas valide"
    redirect_to root_path
    end

    if @candidature.save
      flash[:success] = "Candidature enregistrée"
    else
      flash[:error] = "Une erreur est apparu, veuillez réésayer !"
    end
    redirect_to root_path
  end

  def destroy
    if @candidature.present?
      @candidature.destroy
      flash[:success] = "Votre candidature a bien été retirée."
    else
      flash[:error] = "Impossible de supprimer cette candidature. Veuillez contacter un administrateur"
    end
    redirect_to root_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_candidature
    @candidature = Candidature.find_by(delete_string: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def candidature_params
    params.require(:candidature).permit(:pseudo, :mail, :motivation, :bornDate)
  end
end