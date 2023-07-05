# frozen_string_literal: true

# This class handles the mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
