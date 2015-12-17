class Customer::CustomerMailer < ActionMailer::Base
  default from:  Rails.env.production? ? Environment::FROM_MAIL : "tucamionsoporte@gmail.com"

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
    #puts Environment::MAILSETTING
    #puts "*************************************************************************************************"
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

  def error_payments_confirmation(error, reference, status_pay, amount)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @reference  = reference
    @error      = error
    @status_pay = status_pay
    @amount     = amount
    @payment    = Payment.find_by(reference_code: @reference)
    if @payment
      @user = @payment.customer
      @plan = @payment.offer
    end
    mail to: Rails.env.production? ? "info@camion365.com" : "jonathangrh.25@gmail.com", subject: @error
  end

  def inactive_service_for_system(service)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    @service  = service
    @customer = @service.customer
    mail to: Rails.env.production? ? @customer.email : "jonathangrh.25@gmail.com", subject: "Su servicio con nombre #{@service.name} a caducado"    
  end

  def inactive_extra_for_system(extra)
    
  end

  def approved_payment(payment)
  end

  def rejected_payment(payment)
  end

  def pending_payment(payment)
  end

  def for_win_service(service)
    
  end

  def for_win_extra(extra)
    
  end


end
