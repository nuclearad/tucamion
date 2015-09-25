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
       flash[:warning] = "No hay planes gratuitos por favor comunicarse con el administrador del sistema"
       render :registrar_usuario
     end
  end

  def active_account
    @cliente = Customer.find_by(token_active: params[:token])
    if @cliente
      render :active_account
    else
      @message = true
      flash[:notice] = 'La cuenta se encuentra activa ingrese sus credenciales'
      redirect_to micuenta_path
    end
  end

  def process_account
     token    = params[:customer][:token_active]
     id       = params[:id]
     @cliente = Customer.find_by(id: id, token_active: token, estado: 0)
     if !params[:customer][:clave].blank? && (params[:customer][:clave] == params[:customer][:clave_confirmation])
       params[:customer][:estado]       = Environment::STATUS[:clientes][:activo]
       params[:customer][:token_active] = ''
       if @cliente.update customer_params
         session[:user] = @cliente.id
         redirect_to micuenta_path
       else
         @cliente.token_active = token
         @cliente.estado       = Environment::STATUS[:clientes][:inactivo]
         flash[:warning] = "La cuenta no se pudo activar intente de nuevo"
         render :active_account
       end
     else
        flash[:error] = "Las contraseñas no son iguales"
        render :active_account
     end
  end


  def cambiar_clave_by_ID
    @user= Customer.find(params[:id])
    render layout: 'layouts/cliente'
  end

  def update_clave
    @user=Customer.find(params[:id])
    if @user.is_password?(params[:clave_actual]) && (params[:customer][:clave] == params[:customer][:clave_confirmation])
      if @user.update_attributes(clave: params[:clave])
        flash[:success]='Clave cambiada con exito!'
        redirect_to 'ver perfil'
      end
    end
  end

  def olvido_clave
    if request.post?
      @cliente = Customer.find_by(email: params[:customer][:email])
      if @cliente
         @cliente.token_pass = Digest::MD5.hexdigest("md5tucamion2pass#{Time.now.strftime('%d%m%Y%H%M%S')}")
         url                  = "#{request.protocol}#{request.host_with_port}/cambiar-clave/#{@cliente.token_pass}"
         if @cliente.save
           Customer::CustomerMailer.forgot_pass(@cliente, url).deliver
           flash[:success] = "Se envio un correo a la direccion suministrada siga los pasos para cambiar su contraseña!!!"
           @cliente = Customer.new
         else
           flash[:warning] = "Se produjo un error al generar la transaccion"
           @cliente = Customer.new
         end
      else
        flash[:warning] = "Los datos suministrados son incorrectos"
        @cliente = Customer.new
      end
    else
      @cliente = Customer.new
    end
  end

  def cambiar_clave
    token = params[:token]
    @cliente = Customer.find_by(token_pass: token)
    if @cliente
      render :cambiar_clave
    else
      @message = true
      flash[:warning]= 'La cuenta el token suministrado no es permitido'
      redirect_to micuenta_path     
    end
  end

  def process_change
     token    = params[:customer][:token_pass]
     id       = params[:id]
     @cliente = Customer.find_by(id: id, token_pass: token)
     if !params[:customer][:clave].blank? && (params[:customer][:clave] == params[:customer][:clave_confirmation])
       params[:customer][:token_pass] = ''
       if @cliente.update customer_params
         session[:user] = @cliente.id
         redirect_to micuenta_path
       else
         @cliente.token_pass = token
         flash[:warning]      = "La cuenta no se pudo cambiar la clave intente de nuevo"
         render :cambiar_clave
       end
     else
        flash[:warning] = "Las contraseñas no son iguales"
        render :cambiar_clave
     end
  end
  
  def ver_perfil
    @user=Customer.find(params[:id])
    render layout: 'layouts/cliente'
  end

  def editar_perfil
    @user=Customer.find(params[:id])
    render layout: 'layouts/cliente'
  end


  def actualizar_perfil
    @user= Customer.find(params[:id])
    logger.info 'la cedula es:' + @user.cedula+ 'parametro viene:' + params[:customer][:cedula]
=begin
    if @user.update_attributes(basic_params)
      flash[:notice] = 'Informaci�n actualizada correctamente'
      redirect_to customer_show_path
    else
      render 'editar_perfil'
    end
=end
    redirect_to customer_show_path
  end


  private

    def basic_params
      params.require(:customer).permit(:cedula, :name, :telefono, :email)
    end


    def customer_params
      params.require(:customer).permit(:cedula, :name, :telefono, :email, :clave, :clave_confirmation, :token_active, :estado, :token_pass)
    end

end