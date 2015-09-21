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
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "localhost",
  :user_name            => "tucamionsoporte@gmail.com",
  :password             => "tucamionsoporte",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
