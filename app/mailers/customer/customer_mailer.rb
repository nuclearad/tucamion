class Customer::CustomerMailer < ActionMailer::Base
  default from:  Rails.env.production? ? "info@camion365.com" : "tucamionsoporte@gmail.com"

  def create_by_admin(user, url)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @user                          = user
    @url                           = url
    @subject                       = 'Bienvenido a tucamion365'
    mail to: ["#{@user.name} <#{@user.email}>"], subject: @subject
  end

  def edit_by_admin(user)

  end

  def forgot_pass(user, url)
    puts Environment::MAILSETTING
    puts "*************************************************************************************************"
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @user                          = user
    @url                           = url
    @subject                       = 'NOTIFICACION Tucamion365'
    mail to: ["#{@user.name} <#{@user.email}>"], subject: @subject
  end

  def new_password(admin_user,contra,url)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @admin_user                    = admin_user
    @url                           = url
    @contra                        = contra
    @subject                       = 'NOTIFICACION Tucamion365'
    mail to: ["#{@admin_user.first_name} <#{@admin_user.email}>"], subject: @subject
  end

  def inbox_message(message, object)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @message = message
    if @message.tipo == 1
        @name_flyer = object.nombre
    else
        @name_flyer = object.name
    end 
    @subject = 'Nuevo mensaje Tucamion365'
    mail to: [object.email], subject: @subject
  end

end
