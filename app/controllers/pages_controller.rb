class PagesController < ApplicationController
  layout 'index', :only => [ :index ]

  def terminos

  end

  def politicas

  end

  def index
    self.init_toggle #inicia el despliegue de la busqueda anidada
    @search_serv = Service.search(params[:q])
    @search_repu = Extra.search(params[:q])
    @search_cam  = Truck.search(params[:q])
    @states      = State.all.order(:name)
    @types       = TypeTruck.all.includes(:brand_trucks)
    @banners     = House.all
  end

  def busqueda
    
    strSearch = params[:consulta]
    if strSearch
      if strSearch.size <= 50
        if validate_injection(strSearch) == false
          @trucks   = Truck.like_join(strSearch).includes(:state)
                           .page(params[:page]).per(Environment::LIMIT_SEARCH)

          @extras   = Extra.like_join(strSearch).includes(:state, :city)
                           .page(params[:page]).per(Environment::LIMIT_SEARCH)

          @services = Service.like_join(strSearch).includes(:state, :city)
                             .page(params[:page]).per(Environment::LIMIT_SEARCH)
        else
          @result = 'Se valida la cadena y hay un intento no permitido por favor intentar de nuevo'
        end
      else
        @result = 'La cadena enviada para generar la consulta debe ser menor a 50 caracteres'
      end
    else
        @trucks   = Truck.all.includes(:state)
                           .page(params[:page]).per(Environment::LIMIT_SEARCH)

        @extras   = Extra.all.includes(:state, :city)
                           .page(params[:page]).per(Environment::LIMIT_SEARCH)

        @services = Service.all.includes(:state, :city)
                           .page(params[:page]).per(Environment::LIMIT_SEARCH)
    end
    respond_to do |format|
      format.html { render :busqueda }
      format.js { render :busqueda }
    end
  end

  def tarifas
    @planes = Offer.where(typeoffer: Environment::TYPE[:planes][:pago])
    if !session[:user].nil?
      @user = Customer.find_by_id(session[:user])
    end
  end

  def departamentos

    @cities = City.where(state_id: params[:state_id]).order(:name).all
    @state = State.find_by_id(params[:state_id])

    render :json => @cities

  end

# Camiones
  def micamiones
    if session[:user].nil?
       redirect_to micuenta_path
    else
       @user     = Customer.find_by_id(session[:user])
       @quantity = @user.quantities.first
       @search   = Truck.where(:customer_id => session[:user]).includes(:type_truck, :brand_truck, :state, :messages).search(params[:q])
       @trucks   = @search.result.page(params[:page]).per(Environment::LIMIT_SEARCH)
       render layout: 'layouts/cliente'
    end
  end

  def micamionesnew
    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user     = Customer.find_by_id(session[:user])
      @quantity = @user.quantities.first
      @truck    = Truck.new
      @truck.type_truck_id = params['v']
      @capacidadcarga = Environment::CAPACIDAD_CARGA
      if @quantity.total_trucks - @quantity.current_trucks > 0

        if @user.cargar_planes > 0
          if request.post?
            params[:truck][:customer_id] = session[:user]
            @truck = Truck.new(allowed_params)
            if @truck.save
              flash[:success] = 'Información agregada correctamente'
              redirect_to micamiones_path
            else
              render :micamionesnew, layout: 'layouts/cliente', :v=> @truck.type_truck_id
            end
          else
            render layout: 'layouts/cliente', :v=> @truck.type_truck_id
          end
        else
          redirect_to micamiones_path, flash: {warning: 'No posee planes para realizar la operacion'}
        end
      else
        redirect_to micamiones_path, flash: {warning: 'Debes adquirir un plan para seguir disfrutando del servicio'}
      end
    end
  end

  def micamionesedit

    salved=false
    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user = Customer.find_by_id(session[:user])
      @truck = Truck.where(:id => params[:id], :customer_id => session[:user]).first
      @lateUpdate = @truck.created_at < Date.today - Environment::EXTRA_LATE_UPDATE
      @cities= City.where('state_id = ?', @truck.state_id)
      @placaCities= City.where('state_id =?', @truck.placa_state_id)
      @capacidadcarga = Environment::CAPACIDAD_CARGA
      if @truck.blank?
        redirect_to micamiones_path
      else
        if request.post?

          if @lateUpdate
            salved = @truck.update_attributes(allowed_lateUpdate_params)
          end
          if @truck.update_attributes(allowed_params) or salved
            flash[:success] = 'Información actualizada correctamente'
            redirect_to micamiones_path and return
          else
            @truck.errors.full_messages.each {|e| logger.error e}
            @cities= City.where('state_id = ?', @truck.state_id)
            @placaCities= City.where('state_id =?', @truck.placa_state_id)
            @capacidadcarga = Environment::CAPACIDAD_CARGA
          end
        end
          render layout: 'layouts/cliente'
      end
    end
  end

  def micamionesdelete
    begin
    if session[:user].nil?
      redirect_to micuenta_path
    else
      @truck = Truck.find(params[:id])
      if @truck.destroy
        flash[:success] = 'Información eliminada correctamente'
      else
        flash[:danger] = 'Error eliminando informacion'
      end
    redirect_to micamiones_path
    end
    rescue Exception => e
      redirect_to micamiones_path, flash: {error: e.to_s}
    end
  end

  def sell_truck
    id_truck = params[:id]
    truck = Truck.find_by(id: id_truck, customer_id: session[:user])
    if truck
      if truck.active == 1
        truck.update_attributes(active: Environment::STATUS[:camiones][:vendido])
      end
    end
    redirect_to '/mi-cuenta/camiones'
  end

#repuestos
  def mirepuestos

    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user     = Customer.find_by_id(session[:user])
      @quantity = @user.quantities.first
      @search   = Extra.where(:customer_id => session[:user]).includes(:type_trucks, :brand_extras, :messages).search(params[:q])
      @extras   = @search.result.page(params[:page]).per(Environment::LIMIT_SEARCH)

      render layout: 'layouts/cliente'
    end
  end

  def mirepuestosnew

    if session[:user].nil?
      redirect_to micuenta_path
    else

      @user     = Customer.find_by_id(session[:user])
      @quantity = @user.quantities.first
      @extra    = Extra.new
      @horas = Environment::HORARIOS
      if @quantity.total_extras - @quantity.current_extras > 0
        if @user.cargar_planes > 0
          if request.post?
            params[:extra][:customer_id] = session[:user]
            @extra = Extra.new(allowed_paramsextra)
            if @extra.save
              flash[:success] = 'Información agregada correctamente'
              redirect_to mirepuestos_path
            else
              render :layout => 'layouts/cliente'
            end
          else
            render :layout => 'layouts/cliente'
          end
        else
          redirect_to mirepuestos_path, flash: {warning: 'No posee planes para realizar la operacion'}
        end
      else
        redirect_to mirepuestos_path, flash: {warning: 'Debes adquirir un plan para seguir disfrutando del servicio'}
      end
    end

  end

  def mirepuestosedit
    salved = false
    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user = Customer.find_by_id(session[:user])
      @extra = Extra.find(params[:id])
      @cities= City.where('state_id = ?', @extra.state_id)
      @extraLateUpdate = @extra.created_at < Date.today - Environment::EXTRA_LATE_UPDATE
      @horas = Environment::HORARIOS
        if request.post?
          if @extraLateUpdate
            salved = @extra.update_attributes(allowed_lateUpdate_paramsExtra)
          else
            salved =@extra.update_attributes(allowed_paramsextra)
          end
          if salved
            flash[:success] = 'Información actualizada correctamente'
            redirect_to mirepuestos_path and return
          else
            flash[:error] = 'La Información no se pudo Actualizar'
          end
        end
      render :layout => 'layouts/cliente'
    end
  end

  def mirepuestosdelete
    if session[:user].nil?
      redirect_to micuenta_path
    else
      @extra = Extra.find(params[:id])
      if @extra.destroy
        flash[:success] = 'Información eliminada correctamente'
      else
        flash[:error] = 'Error eliminando informacion'
      end
    redirect_to mirepuestos_path
    end
  end

#Servicios
  def miservicios

    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user       = Customer.find_by_id(session[:user])
      @quantity   = @user.quantities.first
      @search     = Service.where(:customer_id => session[:user]).includes(:type_services, :messages).search(params[:q])
      @servicios  = @search.result.page(params[:page]).per(Environment::LIMIT_SEARCH)

      render :layout => 'layouts/cliente'
    end

  end

  def miserviciosedit

    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user = Customer.find_by_id(session[:user])
      @service = Service.find(params[:id])
      @serviceLateUpdate = @service.created_at < Date.today - Environment::EXTRA_LATE_UPDATE
      @horas = Environment::HORARIOS
      @cities= City.where('state_id = ?', @service.state_id)
      if request.post?
        params[:service][:customer_id] = session[:user]
        if @serviceLateUpdate
          salved=service.update_attributes(allowed_lateUpdate_paramsservice)
        else
          salved=@service.update_attributes(allowed_paramsservice)
        end
        if salved
          flash[:success] = 'Información editada correctamente'
          redirect_to miservicios_path and return
        else
          render :layout => 'layouts/cliente'
        end
      else
        render :layout => 'layouts/cliente'
      end
    end
  end


  def miserviciosnew
    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user     = Customer.find_by_id(session[:user])
      @quantity = @user.quantities.first
      @service  = Service.new
      @horas = Environment::HORARIOS
      if @quantity.total_services - @quantity.current_services > 0
        if @user.cargar_planes > 0
          if request.post?
            params[:service][:customer_id] = session[:user]
            @service = Service.new(allowed_paramsservice)
            if @service.save
              flash[:success] = 'Información agregada correctamente'
              redirect_to miservicios_path
            else
              render layout: 'layouts/cliente'
            end
          else
            render layout: 'layouts/cliente'
          end
        else
          redirect_to miservicios_path, flash: {warning: 'No posee planes para realizar la operacion'}

        end
      else
        redirect_to miservicios_path, flash: {warning: 'Debes adquirir un plan para seguir disfrutando del servicio'}
      end
    end
  end

  def miserviciosdelete
    if session[:user].nil?
      redirect_to micuenta_path
    else
      @service = Service.find(params[:id])
      if @service.destroy
        flash[:success] = 'Información eliminada correctamente'
      else
        flash[:error] = 'Error eliminando informacion'
      end
    redirect_to miservicios_path
    end
  end
#EndServicios

#mi cuenta
  def micuenta

      if session[:user].nil?

        @message = false
        if request.post?
           @usuario = Customer.where('email = ? and clave = ?', params[:email], params[:clave])

          if @usuario.count == 0
            @message = true
            flash[:success] = ' Email o Clave invalida'
           else
            session[:user] = @usuario[0].id
          end
          redirect_to micuenta_path
        else
          render :action => 'micuentalogin', :layout => 'layouts/devise'
        end

      else

        @user = Customer.find_by_id(session[:user])
        # se valida si el plan esta inscrito y esta vigente jonathan
        @user_cargar_planes = @user.cargar_planes
        
        @quantity           = @user.quantities.first
        flash[:warning]     = "Su plan gratis ha caducado su valides fue de 3 meses el plan fue inscrito el #{@user.created_at.strftime('%d-%m-%Y')}" if @user_cargar_planes == -1
        @offers             = Offercustomer.where(:customer_id => session[:user])
        @publicaciones      = Customer.find_by_sql('(SELECT id, nombre, created_at, 1 as tipo FROM trucks WHERE customer_id='+session[:user].to_s+')
      UNION
      (SELECT id,  name, created_at as nombre, 2 as tipo FROM services WHERE customer_id='+session[:user].to_s+')
      UNION
      (SELECT id, name, created_at as nombre, 3 as tipo  FROM extras WHERE customer_id='+session[:user].to_s+')
      ORDER BY created_at DESC')

        render :action => 'micuenta', :layout => 'layouts/cliente'

      end

  end


  def getbrands

    if params[:id] == '0'
      #@brands = BrandTruck.all
      #render json: @brands

      @brands = BrandTruck.all
      render json: @brands

    else
      @brands = Truck.where(type_truck_id: params[:id]).group(:brand_truck_id).includes(:brand_truck)
      render json: @brands, :include =>[:brand_truck]
      #@brands = BrandTruck.where(type_truck_id: params[:id]).all
    end

  end

  def getreferencias

    if params[:id] == '0'

      @referencia = Referencia.all
      render json: @referencia

    else
      @referencia = Truck.where(type_truck_id: params[:id]).group(:referencia_id).includes(:referencia)
      render json: @referencia, :include =>[:referencia]
    end
  end

  def getubicaciones
    if params[:id] == '0'
      @ubicacion = State.all
      render json: @ubicacion
    else
      @ubicacion = Truck.where(type_truck_id: params[:id]).group(:state_id).includes(:state)
      render json: @ubicacion, :include => [:state]
    end
  end

  def getubicacionesextra
    if params[:id] == '0'
      #@brands = BrandTruck.all
      #render json: @brands

      @ubicacion = State.all
      render json: @brands

    else
      #@ubicacion = Extra.where(id: params[:id]).includes(:brand_extras)
      @truck = TypeTruck.where(id: params[:id]).includes(:brand_extras)
      render json: @truck
      #@brands = BrandTruck.where(type_truck_id: params[:id]).all
    end      
  end
  def getbrandsextra

    if params[:id] == '0'
      #@brands = BrandTruck.all
      #render json: @brands

      @brands = BrandExtra.all
      render json: @brands

    else
      @truck = TypeTruck.where(id: params[:id]).includes(:brand_extras)
      render json: @truck, :include =>[:brand_extras]
      #@brands = BrandTruck.where(type_truck_id: params[:id]).all
    end

  end

  def repuesto
    @message = Message.new
    @extra   = Extra.find_by(id: params[:id], active: 1)
    unless @extra
      redirect_to root_path
    end
  end


  #hecho por jonathan rojas 09-09-2015 para cerrar session
  def logout
    session[:user] = nil
    redirect_to '/'
  end

#hecho por jonathan rojas 08-09-2015 para mejorar la busqueda del sitio

  def camiones
    logger.info 'en camiones' 
    self.load_toggle({'q' => params[:q]}.to_s) #enviamos los parametros que vamos a aplilar
    @search          = Truck.where(active: 1).includes(:state).search(params[:q])
    @banners         = get_banners(params[:q])
    @trucks          = @search.result.order(:nombre).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @tiposCaminiones = TypeTruck.all.includes(:sub_trucks)
    @states          = State.all.order(:name)
    @states_group    = Truck.state_group(params[:q])
    @modelos_group   = Truck.modelo_group(params[:q])
    @brand_group     = Truck.marcas_group(params[:q])
    #@km_group        = Truck.km_group
    @toggle_search   = self.nested_search(params[:q])
    respond_to do |format|
      format.html { render :camiones }
      format.js   { render :camiones }
    end
  end

  def camiontipo
    id_sub           = params[:id_sub]
    id_truck         = params[:id_truck]
    @trucks          = Truck.where(sub_truck_id: id_sub, type_truck_id: id_truck, active: 1).includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)
    respond_to do |format|
      format.html { render :camiones }
      format.js   { render :camiones }
    end
  end

  def camionmarca
    id_brand         = params[:id_brand]
    id_truck         = params[:id_truck]
    @search          = Truck.where(brand_truck_id: id_brand, type_truck_id: id_truck, active: 1).includes(:state).search(params[:q])
    @trucks          = @search.result.order(:nombre).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @tiposCaminiones = TypeTruck.includes(:sub_trucks)
    @states          = State.all.order(:name)
    @states_group    = Truck.state_group({type_truck_id_eq: id_truck})
    @modelos_group   = Truck.modelo_group({type_truck_id_eq: id_truck})
    @brand_group     = Truck.marcas_group({type_truck_id_eq: id_truck})
    @banners         = get_banners params[:q]
    #@km_group        = Truck.km_group
    @toggle_search   = Array.new
    respond_to do |format|
      format.html { render :camiones }
      format.js { render :camiones }
    end
  end

  def camion_toggle
    self.read_toggle(params['q']) #leemos el parametro para limpiar la busqueda
    @search          = Truck.where(active: 1).includes(:state).search(self.get_toggle)
    @trucks          = @search.result.order(:nombre).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @tiposCaminiones = TypeTruck.all.includes(:sub_trucks)
    @banners         = get_banners params['q']
    @states          = State.all.order(:name)
    @states_group    = Truck.state_group(self.get_toggle.deep_symbolize_keys)
    @modelos_group   = Truck.modelo_group(self.get_toggle.deep_symbolize_keys)
    #@km_group        = Truck.km_group
    @brand_group     = Truck.marcas_group(self.get_toggle.deep_symbolize_keys)
    @toggle_search = self.nested_search(self.get_toggle)
    respond_to do |format|
      format.html { render :camiones }
      format.js   { render :camiones }
    end
  end

  def camiones_ajax
    field = params[:field]
    value = params[:value]
    if params[:field].to_s == 'kilometraje'
      valores = params[:value] .split('-')
      @trucks = Truck.where("active = 1 and (kilometraje >= #{valores[0]} and kilometraje <= #{valores[1]})").includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)
    else
      @trucks = Truck.where(active: 1, field.to_sym => value).includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)   
    end  
    respond_to do |format|
      format.js { render :camiones }
    end
  end

  def repuestos
    self.load_toggle({'q' => params[:q]}.to_s) #enviamos los parametros que vamos a aplilar
    @search        = Extra.where(active: 1).includes(:state, :city).search(params[:q])
    @extras        = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @banners       = get_banners(params[:q])
    @type_trucks   = TypeTruck.group_by_brand
    @states        = State.all.order(:name)
    @brand_group   = Extra.brand_group
    @states_group  = Extra.state_group
    @toggle_search = self.nested_search(params[:q])
    respond_to do |format|
      format.html { render :repuestos }
      format.js   { render :repuestos }
    end
  end

  def repuestotipo
    id_brand          = params[:id_brand]
    id_truck          = params[:id_truck]
    @extras           = Extra.joins(:type_trucks,:brand_extras).where(extras: {active: 1}, types_truck_extras: {type_truck_id: id_truck} , brand_extras: {id: id_brand}).includes(:state, :city).page(params[:page]).per(Environment::LIMIT_SEARCH)
    
    #@states           = State.all.order(:name)
    #@type_trucks      = TypeTruck.group_by_brand
    #@brand_group      = Extra.brand_group
    #@states_group     = Extra.state_group
    #@toggle_search    = self.nested_search(self.get_toggle) #le enviamos el hash de busqueda
    respond_to do |format|
      #format.html { render :repuestos }
      format.js   { render :repuestos }
    end
  end

  def repuesto_toggle
    self.read_toggle(params['q']) #leemos el parametro para limpiar la busqueda
    @search        = Extra.where(active: 1).includes(:state, :city).search(self.get_toggle)
    @extras        = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @banners       = get_banners params['q']
    @type_trucks   = TypeTruck.group_by_brand
    @states        = State.all.order(:name)
    @brand_group   = Extra.brand_group
    @states_group  = Extra.state_group
    @toggle_search = self.nested_search(self.get_toggle)
    respond_to do |format|
      format.html { render :repuestos }
      format.js   { render :repuestos }
    end
  end

  def repuestos_ajax
    field = params[:field]
    value = params[:value]
    if field == 'brand_extra_id'
      @extras =   Extra.joins(:brand_extras).where(extras: {active: 1}, brand_extras: {id:  value}).includes(:state, :city).page(params[:page]).per(Environment::LIMIT_SEARCH)
    else
      @extras =   Extra.where(active: 1, field.to_sym => value).includes(:state, :city).page(params[:page]).per(Environment::LIMIT_SEARCH)
    end
    respond_to do |format|
      format.js { render :repuestos }
    end
  end

  def servicios
    self.load_toggle({'q' => params[:q]}.to_s) #enviamos los parametros que vamos a aplilar
    @search        = Service.where(active: 1).includes(:state, :city).search(params[:q])
    @services      = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @banners       = Banner.all.order("RAND()").first(2)
    @states        = State.all.order(:name)
    @type_services = TypeService.group_by_services
    @states_group  = Service.state_group
    @toggle_search = self.nested_search(params[:q])
    respond_to do |format|
      format.html { render :servicios }
      format.js { render :servicios }
    end
  end

  def serviciotipo
    id             = params[:id]
    @services      = Service.joins(:services_type_services).where(services_type_services: {type_service_id: id}).includes(:state, :city).page(params[:page]).per(Environment::LIMIT_SEARCH)
    respond_to do |format|
      format.js { render :servicios }
    end
  end

  def service_toggle
    self.read_toggle(params['q']) #leemos el parametro para limpiar la busqueda
    @search        = Service.where(active: 1).includes(:state, :city).search(self.get_toggle)
    @services      = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @banners       = Banner.all.order("RAND()").first(2)
    @states        = State.all.order(:name)
    @type_services = TypeService.group_by_services
    @states_group  = Service.state_group
    @toggle_search = self.nested_search(self.get_toggle) #le enviamos el hash de busqueda
    respond_to do |format|
      format.html { render :servicios }
      format.js { render :servicios }
    end
  end

  def servicios_ajax
    field = params[:field]
    value = params[:value]

    @services = Service.where(active: 1, field.to_sym => value).includes(:state, :city).page(params[:page]).per(Environment::LIMIT_SEARCH)
    respond_to do |format|
      format.js { render :servicios }
    end
  end

  def camion
    @message = Message.new
    @truck   = Truck.find_by(id: params[:id], active: 1)
    @ciudad  = City.find_by_id(@truck.placa_city_id)
    unless @truck
      redirect_to root_path
    end
  end

  def servicio
    @message = Message.new
    @service = Service.find_by(id: params[:id], active: 1)
    unless @service
      redirect_to root_path
    end
  end

  def update_status
    id   = params[:id]
    type = params[:type]

    case type
    when 'truck'
      item = Truck.find_by(id: id, customer_id: session[:user])
      path = '/mi-cuenta/camiones'
    when 'service'
      item = Service.find_by(id: id, customer_id: session[:user])
      path = '/mi-cuenta/servicios'
    when 'extra'
      item = Extra.find_by(id: id, customer_id: session[:user])
      path = '/mi-cuenta/repuestos'
    end

    if item && item.active == 1
      item.update_attributes(active: Environment::STATUS[:camiones][:inactivo])
    else
      item.update_attributes(active: Environment::STATUS[:camiones][:activo])
    end

    redirect_to path

  end


#private
  private

    def get_banners parm
       begin
          if parm[:type_trucks_id_eq]
            Banner.where(type_truck_id: parm[:type_trucks_id_eq]).order("RAND()").first(2)
          elsif parm[:type_truck_id_eq].blank? || parm[:type_truck_id_eq].nil?
            Banner.all.order("RAND()").first(2)
          else
            Banner.where(type_truck_id: parm[:type_truck_id_eq]).order("RAND()").first(2)
          end
       rescue Exception => e
          begin
            if parm["type_trucks_id_eq"]
               Banner.where(type_truck_id: parm["type_trucks_id_eq"]).order("RAND()").first(2)
            elsif parm['type_truck_id_eq'].blank? || parm['type_truck_id_eq'].nil?
              Banner.all.order("RAND()").first(2)
            else
              Banner.where(type_truck_id: parm['type_truck_id_eq']).order("RAND()").first(2)
            end      
          rescue Exception => e
             Banner.all.order("RAND()").first(2)
          end
       end
    end

    def validate_injection(str)
       array_str = str.split(' ')
       array_str.each do |word|
         result = Environment::ARRAYSQL[word.downcase]
         return true if result
       end
       return false
    end

    def allowed_lateUpdate_params
      params.require(:truck).permit(:id,:active,:price, :phone, :email, customer_attributes:[:id,:telefono,:email])
    end

    def allowed_lateUpdate_paramsExtra
      params.require(:extra).permit(:id, :active, :nit, :phone, :email, customer_attributes:[:id,:telefono,:email])
    end

    def allowed_lateUpdate_paramsservice
      params.require(:service).permit(:id,:active, :nit, :phone, :email, custmoer_attributes:[:id,:telefono,:email])
    end

    def allowed_params
      params.require(:truck).permit!
    end

    def allowed_paramsextra
      params.require(:extra).permit!
    end

    def allowed_paramsservice
      params.require(:service).permit!
    end
end
