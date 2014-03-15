# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Recrutement::Application.initialize!

# Configurations pour l'envoie des mails
ActionMailer::Base.smtp_settings = {
    :address              => "",
    :port                 => 587,
    :domain               => "",
    :user_name            => "",
    :password             => "",
    :authentication       => "plain",
    :enable_starttls_auto => true
}