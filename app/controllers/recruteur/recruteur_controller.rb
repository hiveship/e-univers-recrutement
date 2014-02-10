class Recruteur::RecruteurController < ApplicationController
  before_filter :require_login
  layout :set_layout
end