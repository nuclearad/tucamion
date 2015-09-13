class SessionsController < ApplicationController
	
  #hecho por jonathan rojas 09-09-2015 para cerrar session
  def logout
    session[:user] = nil
    redirect_to "/"
  end

  def registrar_usuario	
    @cliente = Customer.new
  end

  def crear_usuario
     @cliente        = Customer.new customer_params
     @cliente.estado = Environment::STATUS[:clientes][:activo]
     #if @cliente.save
     #  session[:user] = @cliente.id
     #  redirect_to micuenta_path
     #else
     #  render :registrar_usuario
     #end
  end

  private

    def customer_params
      params.require(:customer).permit(:cedula, :name, :email, :clave, :confirm_clave)
    end

end