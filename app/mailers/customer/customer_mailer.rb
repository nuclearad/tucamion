class Customer::CustomerMailer < ActionMailer::Base
  default from: "tucamionsoporte@gmail.com"

  def create_by_admin(user, url)
  	@user    = user
  	@url     = url
  	@subject = 'Registro de una cuenta en Tucamion' 
    mail to: [@user.email], subject: @subject
  end

  def edit_by_admin(user)
  	
  end

end
