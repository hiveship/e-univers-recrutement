class Admin::AdminController < ApplicationController
  before_filter :require_login, :have_admin_rights
  layout :set_layout

end