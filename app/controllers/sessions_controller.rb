class SessionsController < ApplicationController
	
  #hecho por jonathan rojas 09-09-2015 para cerrar session
  def login
     @message = false
     @usuario = Customer.find_by(email: params[:email], estado: Environment::STATUS[:clientes][:activo])
     if @usuario
       if @usuario.is_password?(params[:clave])
         session[:user] = @usuario.id
         redirect_to micuenta_path
       else
         @message = true
         flash[:notice] = ' Email o Clave invalida'
         render '/pages/micuentalogin', :layout => 'layouts/devise'
       end
     else
       @message = true
       flash[:notice] = 'Email o Cliente inhabilitado'
       render '/pages/micuentalogin', :layout => 'layouts/devise'
     end
  end


  def logout
    session[:user] = nil
    redirect_to "/"
  end

  def registrar_usuario	
    @cliente = Customer.new
  end

  def crear_usuario
     @cliente          = Customer.new customer_params
     @cliente.estado   = Environment::STATUS[:clientes][:activo]
     @cliente.typeuser = Environment::TYPE[:clientes][:normal]
     free_plan         = Offer.find_by(precio1: 0, precio2: 0, typeoffer: Environment::TYPE[:planes][:promocional])
     if free_plan
       if @cliente.save
         Offercustomer.create(customer_id: @cliente.id, offer_id: free_plan.id)
         session[:user] = @cliente.id
         redirect_to micuenta_path
       else
         render :registrar_usuario
       end
     else
       flash[:error] = "No hay planes gratuitos por favor comunicarse con el administrador del sistema"
       render :registrar_usuario
     end
  end

  private

    def customer_params
      params.require(:customer).permit(:cedula, :name, :telefono, :email, :clave, :clave_confirmation)
    end

end