class CandidaturesController < ApplicationController
  before_action :set_candidature, only: [:show, :edit, :update, :destroy]

  # GET /candidatures
  # GET /candidatures.json
  def index
    @candidatures = Candidature.all
  end

  # GET /candidatures/1
  # GET /candidatures/1.json
  def show
  end

  # GET /candidatures/new
  def new
    @candidature = Candidature.new
  end

  # GET /candidatures/1/edit
  def edit
  end

  # POST /candidatures
  # POST /candidatures.json
  def create

    set_session # Permet de connaître la session actuelle
    @candidature = Candidature.new(candidature_params)

    # Vérification de la date de naissance
    if @candidature.valid_born_date
      flash[:error] = "Erreur, la date de naissance doit être inférieur à la date d'aujourd'hui"
      redirect_to new_admin_candidatures_path
    end

    # Le résultat de la candidature est indéfini à sa création
    @candidature.result = Candidature::INDEFINI
    @candidature.submitDate = Date.today
    @candidature.session_id = @session.id

    respond_to do |format|
      if @candidature.save
        flash[:info] = "Candidature enregistrée"
        format.html { redirect_to root_path, notice: 'La candidature a bien été créée.' }
        format.json { render action: 'show', status: :created, location: @candidature }
      else
        format.html { render action: 'new' }
        format.json { render json: @candidature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidatures/1
  # PATCH/PUT /candidatures/1.json
  def update
    respond_to do |format|
      if @candidature.update(candidature_params)
        format.html { redirect_to @candidature, notice: 'Candidature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @candidature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidatures/1
  # DELETE /candidatures/1.json
  def destroy
    @candidature.destroy
    respond_to do |format|
      format.html { redirect_to candidatures_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_candidature
    @candidature = Candidature.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def candidature_params
    params.require(:candidature).permit(:pseudo, :mail, :motivation, :submitDate, :bornDate, :result, :id_session)
  end

  def set_session
    @session = Session.find_by(params[:id])
  end

end
