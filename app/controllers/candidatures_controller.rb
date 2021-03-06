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
      if @candidature.save
        flash[:success] = "Candidature enregistrée"
        redirect_to root_path
      else
        render action: :new
      end
    else
      flash[:error] = "Une candidature éxiste déjà à votre nom"
      render action: :new
    end
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