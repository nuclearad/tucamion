=begin
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "jrojas@nuclearagenciadigital.com",
  :password             => "",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
=end
ActionMailer::Base.smtp_settings = {
  :address              => Environment::MAILSETTING[:address],
  :port                 => Environment::MAILSETTING[:port],
  :domain               => Environment::MAILSETTING[:domain],
  :user_name            => Environment::MAILSETTING[:user_name],
  :password             => Environment::MAILSETTING[:password],
  :authentication       => Environment::MAILSETTING[:authentication],
  :enable_starttls_auto => Environment::MAILSETTING[:enable_starttls_auto]
}
