# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.

Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'gmail.com',
    user_name:            ENV["GMAIL_USERNAME"],
    password:             ENV["GMAIL_PASSWORD"],
    authentication:       :plain,
    enable_starttls_auto: true
}

ActsAsTaggableOn.force_lowercase = true

require 'rmagick'
require 'carrierwave/orm/activerecord'

