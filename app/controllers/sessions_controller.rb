class SessionsController < ApplicationController

  def index
    @sessions = Session.all
  end

  def show
  end

end
