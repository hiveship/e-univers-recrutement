# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
ProjetRecrutement::Application.initialize!

# Configurations pour l'envoie des mails
ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "gmail.com",
    :user_name            => "projet.test.univers", # Nom d'utilisateur (ici GMail)
    :password             => "eunivers", # Password de messagerie
    :authentication       => "plain",
    :enable_starttls_auto => true
}