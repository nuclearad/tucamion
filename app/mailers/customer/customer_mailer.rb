class Customer::CustomerMailer < ActionMailer::Base
  default from: "tucamionsoporte@gmail.com"

  def create_by_admin(user, url)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
  	@user    = user
  	@url     = url
  	@subject = 'Bienvenido a tucamion365'
    mail to: ["#{@user.name} <#{@user.email}>"], subject: @subject
  end

  def edit_by_admin(user)
  	
  end

  def forgot_pass(user, url)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @user    = user
    @url     = url
    @subject = 'NOTIFICACION Tucamion365'
    mail to: ["#{@user.name} <#{@user.email}>"], subject: @subject    
  end

end
