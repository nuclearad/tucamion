class Customer::CustomerMailer < ActionMailer::Base
  default from: "tucamionsoporte@gmail.com"

  def create_by_admin(user, url)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
  	@user    = user
  	@url     = url
  	@subject = 'Registro en Tucamion'
    mail to: [@user.email], subject: @subject
  end

  def edit_by_admin(user)
  	
  end

end
