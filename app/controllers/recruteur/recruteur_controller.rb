class Recruteur::RecruteurController < ApplicationController
  layout 'recruteur'
  before_filter :require_login


end