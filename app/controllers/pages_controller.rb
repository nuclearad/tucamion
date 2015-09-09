class PagesController < ApplicationController
  layout 'index', :only => [ :index ]
  before_action :load_banners

  def index
    self.init_toggle #inicia el despliegue de la busqueda anidada
    @search_serv = Service.search(params[:q])
    @search_repu = Extra.search(params[:q])
    @search_cam  = Truck.search(params[:q])
    @states      = State.all.order(:name)
    @types       = TypeTruck.all
    @banners     = House.all
  end

  def busqueda

    strSearch = params[:consulta]
    if strSearch.size <= 50
      if validate_injection(strSearch) == false
        @trucks   = Truck.joins(:brand_truck, :type_truck, :sub_truck)
                         .like_join(strSearch).includes(:state)
                         .page(params[:page]).per(Environment::LIMIT_SEARCH)

        @extras   = Extra.joins(:brand_extra, :type_truck)
                         .like_join(strSearch).includes(:state, :city)
                         .page(params[:page]).per(Environment::LIMIT_SEARCH)

        @services = Service.joins(:type_service)
                           .like_join(strSearch).includes(:state, :city)
                           .page(params[:page]).per(Environment::LIMIT_SEARCH)
      else
        @result = "Se valida la cadena y hay un intento no permitido por favor intentar de nuevo" 
      end
    else
      @result = "La cadena enviada para generar la consulta debe ser menor a 50 caracteres"
    end

  end


  def tarifas
    @planes = Offer.all


    if !session[:user].nil?

      @user = Customer.find_by_id(session[:user])
    end

  end


  def departamentos

    @cities = City.where(state_id: params[:state_id]).order(:name).all
    @state = State.find_by_id(params[:state_id])

    render :json => @cities

  end

  def comprar

    if params[:plan].nil?
      redirect_to tarifas_path
    else

      @plan = Offer.find_by_id(params[:plan])
      if !session[:user].nil?
        @user = Customer.find_by_id(session[:user])
      end
      if @plan.blank?
        redirect_to tarifas_path
      end
    end

  end


  def guardarMensaje

    o = Message.new(
        :nombre => params[:nombre],
        :telefono => params[:telefono],
        :mensaje => params[:mensaje],
        :tipo => params[:tipo],
        :item => params[:item]
    )
    if o.save

    data = [:estado => 'si']
    render json: data


    end

  end

  def guardarCustomer


    if Customer.find_by_email(params[:email])
      data = [:estado => 'si']
    else
      data = [:estado => 'no']

      o = Customer.new(
          :name => params[:name],
          :cedula => params[:cedula],
          :telefono => params[:telefono],
          :clave => params[:clave],
          :email => params[:email],
          :typeuser =>  0
      )
      if o.save

        plancliente = Offercustomer.new

        plancliente.customer_id = o.id
        plancliente.offer_id = params[:plan]

        if plancliente.save

          session[:user] = o.id
          data = [:guardoplan => 'si']
        end

      end

    end

    render json: data
  end


  def micamiones

    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user = Customer.find_by_id(session[:user])
      @trucks = Truck.where(:customer_id => session[:user])

      render :layout => 'layouts/cliente'
    end
  end


  def micamionesnew
    if session[:user].nil?
      redirect_to micuenta_path
    else

      @user = Customer.find_by_id(session[:user])
      @truck = Truck.new

      if request.post?

        params[:truck][:customer_id] = session[:user]
        @truck = Truck.new(allowed_params)
        if @truck.save
          flash[:notice] = 'Información agregada correctamente'
          redirect_to micamiones_path
        else
          render 'new'
        end

      else
        render :layout => 'layouts/cliente'
      end

    end
  end


  def micamionesedit
    if session[:user].nil?
      redirect_to micuenta_path
    else

      @user = Customer.find_by_id(session[:user])
      @truck = Truck.where(:id => params[:id], :customer_id => session[:user]).first
      @lateUpdate = @truck.created_at < Date.today - Constants::TRUCK_LATE_UPDATE

      if @truck.blank?
        redirect_to micamiones_path
      else

        if request.post?

          if @lateUpdate
            salved = @truck.update_attributes(allowed_lateUpdate_params)
          end
          if @truck.update_attributes(allowed_params) or salved
            flash[:notice] = 'Información actualizada correctamente'
            redirect_to micamiones_path
          else
            flash[:notice] = 'Informasssción actualizada correctamente'
            redirect_to micamiones_path
          end
        else
          render :layout => 'layouts/cliente'
        end

      end

    end
  end


  def mirepuestos

    if session[:user].nil?
      redirect_to micuenta_path
    else

      @user = Customer.find_by_id(session[:user])
      @extras = Extra.where(:customer_id => session[:user])
      render :layout => 'layouts/cliente'

      puts @extras
    end
  end


  def mirepuestosnew
    if session[:user].nil?
      redirect_to micuenta_path
    else

      @user = Customer.find_by_id(session[:user])
      @extra = Extra.new

      if request.post?

        params[:extra][:customer_id] = session[:user]
        @extra = Extra.new(allowed_paramsextra)
        if @extra.save
          flash[:notice] = 'Información agregada correctamente'
          redirect_to mirepuestos_path
        else
          render 'new'
        end

      else
        render :layout => 'layouts/cliente'
      end

    end
  end

  def mirepuestosedit

    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user = Customer.find_by_id(session[:user])
      @extra = Extra.find(params[:id])
      @extraLateUpdate = @extra.created_at < Date.today - Constants::EXTRA_LATE_UPDATE
      render :layout => 'layouts/cliente'
    end

  end

  def miservicios

    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user = Customer.find_by_id(session[:user])
      @servicios = Service.where(:customer_id => session[:user])
      render :layout => 'layouts/cliente'
    end


  end


  def miserviciosedit

    if session[:user].nil?
      redirect_to micuenta_path
    else
      @user = Customer.find_by_id(session[:user])
      @service = Service.find(params[:id])
      @serviceLateUpdate = @service.created_at < Date.today - Constants::EXTRA_LATE_UPDATE
      render :layout => 'layouts/cliente'
    end

  end


  def miserviciosnew
    if session[:user].nil?
      redirect_to micuenta_path
    else

      @user = Customer.find_by_id(session[:user])
      @service = Service.new

      if request.post?

        params[:service][:customer_id] = session[:user]
        @service = Service.new(allowed_paramsservice)
        if @service.save
          flash[:notice] = 'Información agregada correctamente'
          redirect_to miservicios_path
        else
          render 'new'
        end

      else
        render :layout => 'layouts/cliente'
      end

    end
  end


  def micuenta

      if session[:user].nil?

            @message = false
            if request.post?
              @usuario = Customer.where('email = ? and clave = ?', params[:email], params[:clave])

              if @usuario.count == 0
                @message = true
                flash[:notice] = ' Email o Clave invalida'
              else
                session[:user] = @usuario[0].id


              end
              redirect_to micuenta_path
            else
              render :action => 'micuentalogin', :layout => 'layouts/devise'
            end

      else

        @user = Customer.find_by_id(session[:user])
         
        @offers = Offercustomer.where(:customer_id => session[:user])


        @publicaciones  = Customer.find_by_sql('(SELECT id, nombre, created_at, 1 as tipo FROM trucks WHERE customer_id='+session[:user].to_s+')
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


  def getbrandsextra

    if params[:id] == '0'
      #@brands = BrandTruck.all
      #render json: @brands

      @brands = BrandExtra.all
      render json: @brands

    else
      @brands = Extra.where(type_truck_id: params[:id]).group(:brand_extra_id).includes(:brand_extra)
      render json: @brands, :include =>[:brand_extra]
      #@brands = BrandTruck.where(type_truck_id: params[:id]).all
    end

  end

  def repuesto
    @extra = Extra.find_by_id(params[:id])
  end

  def camiones_backup
   
    @fullbBase = request.original_url
    @queryModelos = []
    @queryStates = []
    @queryTrucks = []
    @parametroPrincipal = false
    @muestroEstado = true
    @muestroMarca = true
    @mostrarKm = true
    @mostrarEstado = true
    @mostrarPlaca = true
    @mostrarPrice  = true



    @banners = Banner.all.order('rand()').limit(3)
    @tiposCaminiones = TypeTruck.all.includes(:sub_trucks)

    if(params[:param1].nil? && params[:param2].nil? && params[:param3].nil?)

      @trucks = Truck.where(active: 1).all.includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)

      @modelos = Truck.
          select('modelo, count(modelo) as total').
          group('modelo').
          order('modelo DESC')

      @estado = Truck.
          select('
          SUM(CASE WHEN estado = 0 THEN 1 ELSE 0 END) AS nuevo,
          SUM(CASE WHEN estado = 1 THEN 1 ELSE 0 END) AS usado')




      @km = Truck.
          select('
          SUM(CASE WHEN kilometraje = 0 THEN 1 ELSE 0 END) AS price_range_1,
SUM(CASE WHEN kilometraje >= 1 and kilometraje <=25000 THEN 1 ELSE 0 END) AS price_range_2,
SUM(CASE WHEN kilometraje >= 25001 and kilometraje <=50000 THEN 1 ELSE 0 END) AS price_range_3,
SUM(CASE WHEN kilometraje >= 50001 and kilometraje <=100000 THEN 1 ELSE 0 END) AS price_range_4,
SUM(CASE WHEN kilometraje >100000 THEN 1 ELSE 0 END) AS price_range_5')




      @states = Truck.
          joins(:state).
          select('name, count(name) as total, states.link_rewrite').
          group('name').
          order('name DESC')



      @statesPlaca = Truck.
          joins('join states on states.id = trucks.placa_state_id',).
          select('name, count(name) as total, states.link_rewrite').
          group('name').
          order('name DESC')




      @brands = Truck.
          joins(:brand_truck).
          select('name, count(name) as total, brand_trucks.link_rewrite').
          group('name').
          order('name DESC')




    end


    #busqueda de un parametro
    if(!params[:param1].nil? && params[:param2].nil? && params[:param3].nil?)




      params[:param1current] =  params[:param1]

      if params[:param1current].include? '_'
        @url =  params[:param1current].split('_')

        params[:param1] =  @url[0]

        if @url.index('modelo')

          valor = @url[@url.index('modelo')+1]
          @queryModelos.push(['modelo', valor])
          @queryTrucks.push(['modelo',valor])
        end

      end




      if params[:param1current].include? '_'
        @url =  params[:param1current].split('_')

        params[:param1] =  @url[0]

        if @url.index('estado')
          @mostrarEstado = false
          valor = @url[@url.index('estado')+1]
          @queryModelos.push(['estado', valor])
          @queryTrucks.push(['estado',valor])
        end

      end



      if params[:param1current].include? '_'
        @url =  params[:param1current].split('_')

        params[:param1] =  @url[0]

        if @url.index('placa')
          @mostrarPlaca  = false
          valor = @url[@url.index('placa')+1]
          @queryModelos.push(['placa', valor])
          @queryTrucks.push(['placa',valor])

        end

      end




      if params[:param1current].include? '_'
        @url =  params[:param1current].split('_')

        params[:param1] =  @url[0]

        if @url.index('precio')
          @mostrarPrice  = false
          valor = @url[@url.index('precio')+1]
          @queryModelos.push(['precio', valor])
          @queryTrucks.push(['precio',valor])

        end

      end


      if params[:param1current].include? '_'

        @url =  params[:param1current].split('_')

        params[:param1] =  @url[0]

        if @url.index('kilometraje')
          @mostrarKm = false

          valor = @url[@url.index('kilometraje')+1]


         if (valor.to_i == 0)
               @queryModelos.push(['kilometraje', '0'])
               @queryTrucks.push(['kilometraje','0'])

         else  if(valor.to_i > 0 && valor.to_i < 100001)

                valores = valor.split('-')

                valor = '-kilometraje-'+valores[0]+'-kilometraje-'+valores[1]

                @queryModelos.push(['kilometraje', valor])
                @queryTrucks.push(['kilometraje',valor])
            else if (valor.to_i >= 100001)

                   @queryModelos.push(['kilometraje', '100001'])
                   @queryTrucks.push(['kilometraje','100001'])

                      end
            end
          end




        end

      end


        @trucks = Truck.where(toSql(@queryTrucks)).all.includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)


        if TypeTruck.where(link_rewrite: params[:param1]).exists?
          @parametroPrincipal = true
          types = TypeTruck.find_by_link_rewrite(params[:param1])

          @queryTrucks.push(['type_truck_id', types.id])
          @trucks = Truck.where(toSql(@queryTrucks)).all.includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)


          @queryModelos.push (['type_truck_id', types.id])

          @p1 = 'type'



        end


        if BrandTruck.where(link_rewrite: params[:param1]).exists?
          @parametroPrincipal = true
          @muestroMarca = false
          brand = BrandTruck.find_by_link_rewrite(params[:param1])
          @queryTrucks.push(['brand_truck_id', brand.id])
          @trucks = Truck.where(toSql(@queryTrucks)).all.includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)

          @queryModelos.push (['brand_truck_id', brand.id])

          @p1 = 'brand'

        end


        if State.where(link_rewrite: params[:param1]).exists?
          state = State.find_by_link_rewrite(params[:param1])
          @parametroPrincipal = true
          @muestroEstado = false

          @queryTrucks.push(['state_id', state.id])
          @trucks = Truck.where(toSql(@queryTrucks)).all.includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)


          @queryModelos.push (['state_id', state.id])

          @p1 = 'state'

        end



        @modelos = Truck.
            where(toSql(@queryModelos)).
            select('modelo, count(modelo) as total').
            group('modelo').
            order('modelo DESC')


        @states = Truck.
            joins(:state).
            where(toSql(@queryModelos)).
            select('name, count(name) as total, states.link_rewrite').
            group('name').
            order('name DESC')



      @brands = Truck.
          joins(:brand_truck).
          where(toSql(@queryModelos)).
          select('name, count(name) as total, brand_trucks.link_rewrite').
          group('name').
          order('name DESC')



      @km = Truck.
          select('
          SUM(CASE WHEN kilometraje = 0 THEN 1 ELSE 0 END) AS price_range_1,
SUM(CASE WHEN kilometraje >= 1 and kilometraje <=25000 THEN 1 ELSE 0 END) AS price_range_2,
SUM(CASE WHEN kilometraje >= 25001 and kilometraje <=50000 THEN 1 ELSE 0 END) AS price_range_3,
SUM(CASE WHEN kilometraje >= 50001 and kilometraje <=100000 THEN 1 ELSE 0 END) AS price_range_4,
SUM(CASE WHEN kilometraje >100000 THEN 1 ELSE 0 END) AS price_range_5').
          where(toSql(@queryModelos))


      @estado = Truck.
          select('
          SUM(CASE WHEN estado = 0 THEN 1 ELSE 0 END) AS nuevo,
          SUM(CASE WHEN estado = 1 THEN 1 ELSE 0 END) AS usado').
          where(toSql(@queryModelos))


      @statesPlaca = Truck.
          joins('join states on states.id = trucks.placa_state_id',).
          select('name, count(name) as total, states.link_rewrite').
          group('name').
          order('name DESC').
          where(toSql(@queryModelos))

    end


    #busqueda de dos parametro
    if(!params[:param1].nil? && !params[:param2].nil? && params[:param3].nil?)
      @p1 = nil
      @p2 = nil
      @queryTrucks = []


      if TypeTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param1])).exists?
        @p1 = 'type'

        type = TypeTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param1]))
        @queryTrucks.push(['type_truck_id', type.id])

      end


      if BrandTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param1])).exists?
        @p1 = 'brand'

        brand = BrandTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param1]))
        @queryTrucks.push(['brand_truck_id', brand.id])
      end


      if State.where(link_rewrite: extraigoParametroprincicpal(params[:param1])).exists?
        @p1 = 'state'

        state = State.find_by_link_rewrite(extraigoParametroprincicpal(params[:param1]))
        @queryTrucks.push(['state_id', state.id])
      end


      if TypeTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param2])).exists?
        @p2 = 'type'

        type = TypeTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param2]))
        @queryTrucks.push(['type_truck_id', type.id])

      end


      if BrandTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param2])).exists?
        @p2 = 'brand'

        brand = BrandTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param2]))
        @queryTrucks.push(['brand_truck_id', brand.id])
      end


      if State.where(link_rewrite: extraigoParametroprincicpal(params[:param2])).exists?
        @p2 = 'state'

        state = State.find_by_link_rewrite(extraigoParametroprincicpal(params[:param2]))
        @queryTrucks.push(['state_id', state.id])
      end


      if params[:param2].include? '_'

        @parametroUrl =  params[:param2].split('_')

        if @parametroUrl.index('modelo')
          @mostrarModelo = false;
          valor = @parametroUrl[@parametroUrl.index('modelo') + 1]
          @queryTrucks.push(['modelo',valor])
        end



        if @parametroUrl.index('estado')
          @mostrarEstado = false
          valor = @parametroUrl[@parametroUrl.index('estado')+1]
          @queryTrucks.push(['estado',valor])
        end



        if @parametroUrl.index('placa')
          @mostrarPlaca = false
          valor = @parametroUrl[@parametroUrl.index('placa')+1]
          @queryTrucks.push(['placa',valor])
        end


        if @parametroUrl.index('precio')
          @mostrarPrice  = false
          valor = @parametroUrl[@parametroUrl.index('precio')+1]
          @queryTrucks.push(['precio',valor])

        end



        if @parametroUrl.index('kilometraje')
          @mostrarKm = false

          valor = @parametroUrl[@parametroUrl.index('kilometraje')+1]


          if (valor.to_i == 0)
            @queryTrucks.push(['kilometraje','0'])

          else  if(valor.to_i > 0 && valor.to_i < 100001)

                  valores = valor.split('-')

                  valor = '-kilometraje-'+valores[0]+'-kilometraje-'+valores[1]

                  @queryTrucks.push(['kilometraje',valor])
                else if (valor.to_i >= 100001)

                       @queryTrucks.push(['kilometraje','100001'])

                     end
                end
          end

        end


      end


      @trucks = Truck.where(toSql(@queryTrucks)).all.includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)


      @modelos = Truck.
          where(toSql(@queryTrucks)).
          select('modelo, count(modelo) as total').
          group('modelo').
          order('modelo DESC')


      @states = Truck.
          joins(:state).
          where(toSql(@queryTrucks)).
          select('name, count(name) as total, states.link_rewrite').
          group('name').
          order('name DESC')



      @brands = Truck.
          joins(:brand_truck).
          where(toSql(@queryTrucks)).
          select('name, count(name) as total, brand_trucks.link_rewrite').
          group('name').
          order('name DESC')



      @km = Truck.
          select('
          SUM(CASE WHEN kilometraje = 0 THEN 1 ELSE 0 END) AS price_range_1,
SUM(CASE WHEN kilometraje >= 1 and kilometraje <=25000 THEN 1 ELSE 0 END) AS price_range_2,
SUM(CASE WHEN kilometraje >= 25001 and kilometraje <=50000 THEN 1 ELSE 0 END) AS price_range_3,
SUM(CASE WHEN kilometraje >= 50001 and kilometraje <=100000 THEN 1 ELSE 0 END) AS price_range_4,
SUM(CASE WHEN kilometraje >100000 THEN 1 ELSE 0 END) AS price_range_5').
          where(toSql(@queryTrucks))


      @estado = Truck.
          select('
          SUM(CASE WHEN estado = 0 THEN 1 ELSE 0 END) AS nuevo,
          SUM(CASE WHEN estado = 1 THEN 1 ELSE 0 END) AS usado').
          where(toSql(@queryTrucks))


      @statesPlaca = Truck.
          joins('join states on states.id = trucks.placa_state_id',).
          select('name, count(name) as total, states.link_rewrite').
          where(toSql(@queryTrucks)).
          group('name').
          order('name DESC')


    end





    #tres
    if(!params[:param1].nil? && !params[:param2].nil? && !params[:param3].nil?)


      @p1 = nil
      @p2 = nil
      @p3 = nil
      @queryTrucks = []


      if TypeTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param1])).exists?
        @p1 = 'type'
        type = TypeTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param1]))
        @queryTrucks.push(['type_truck_id', type.id])

      end


      if BrandTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param1])).exists?
        @p1 = 'brand'

        brand = BrandTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param1]))
        @queryTrucks.push(['brand_truck_id', brand.id])
      end


      if State.where(link_rewrite: extraigoParametroprincicpal(params[:param1])).exists?
        @p1 = 'state'

        state = State.find_by_link_rewrite(extraigoParametroprincicpal(params[:param1]))
        @queryTrucks.push(['state_id', state.id])
      end


      if TypeTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param2])).exists?
        @p2 = 'type'

        type = TypeTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param2]))
        @queryTrucks.push(['type_truck_id', type.id])

      end


      if BrandTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param2])).exists?
        @p2 = 'brand'

        brand = BrandTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param2]))
        @queryTrucks.push(['brand_truck_id', brand.id])
      end


      if State.where(link_rewrite: extraigoParametroprincicpal(params[:param2])).exists?
        @p2 = 'state'

        state = State.find_by_link_rewrite(extraigoParametroprincicpal(params[:param2]))
        @queryTrucks.push(['state_id', state.id])
      end


      if TypeTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param3])).exists?
        @p3 = 'type'

        type = TypeTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param3]))
        @queryTrucks.push(['type_truck_id', type.id])

      end


      if BrandTruck.where(link_rewrite: extraigoParametroprincicpal(params[:param3])).exists?
        @p3 = 'brand'

        brand = BrandTruck.find_by_link_rewrite(extraigoParametroprincicpal(params[:param3]))
        @queryTrucks.push(['brand_truck_id', brand.id])
      end


      if State.where(link_rewrite: extraigoParametroprincicpal(params[:param3])).exists?
        @p3 = 'state'

        state = State.find_by_link_rewrite(extraigoParametroprincicpal(params[:param3]))
        @queryTrucks.push(['state_id', state.id])
      end


      if params[:param3].include? '_'

        @parametroUrl =  params[:param3].split('_')

        if @parametroUrl.index('modelo')
          @mostrarModelo = false;
          valor = @parametroUrl[@parametroUrl.index('modelo') + 1]
          @queryTrucks.push(['modelo',valor])
        end



        if @parametroUrl.index('estado')
          @mostrarEstado = false
          valor = @parametroUrl[@parametroUrl.index('estado')+1]
          @queryTrucks.push(['estado',valor])
        end



        if @parametroUrl.index('placa')
          @mostrarPlaca = false
          valor = @parametroUrl[@parametroUrl.index('placa')+1]
          @queryTrucks.push(['placa',valor])
        end


        if @parametroUrl.index('precio')
          @mostrarPrice  = false
          valor = @parametroUrl[@parametroUrl.index('precio')+1]
          @queryTrucks.push(['precio',valor])

        end


        if @parametroUrl.index('kilometraje')
          @mostrarKm = false

          valor = @parametroUrl[@parametroUrl.index('kilometraje')+1]


          if (valor.to_i == 0)
            @queryTrucks.push(['kilometraje','0'])

          else  if(valor.to_i > 0 && valor.to_i < 100001)

                  valores = valor.split('-')
                  valor = '-kilometraje-'+valores[0]+'-kilometraje-'+valores[1]
                  @queryTrucks.push(['kilometraje',valor])
                else if (valor.to_i >= 100001)
                       @queryTrucks.push(['kilometraje','100001'])
                     end
                end
          end


          end

      end


      @trucks = Truck.where(toSql(@queryTrucks)).all.includes(:state).page(params[:page]).per(Environment::LIMIT_SEARCH)


      @modelos = Truck.
          where(toSql(@queryTrucks)).
          select('modelo, count(modelo) as total').
          group('modelo').
          order('modelo DESC')


      @states = Truck.
          joins(:state).
          where(toSql(@queryTrucks)).
          select('name, count(name) as total, states.link_rewrite').
          group('name').
          order('name DESC')



      @brands = Truck.
          joins(:brand_truck).
          where(toSql(@queryTrucks)).
          select('name, count(name) as total, brand_trucks.link_rewrite').
          group('name').
          order('name DESC')



      @km = Truck.
          select('
          SUM(CASE WHEN kilometraje = 0 THEN 1 ELSE 0 END) AS price_range_1,
SUM(CASE WHEN kilometraje >= 1 and kilometraje <=25000 THEN 1 ELSE 0 END) AS price_range_2,
SUM(CASE WHEN kilometraje >= 25001 and kilometraje <=50000 THEN 1 ELSE 0 END) AS price_range_3,
SUM(CASE WHEN kilometraje >= 50001 and kilometraje <=100000 THEN 1 ELSE 0 END) AS price_range_4,
SUM(CASE WHEN kilometraje >100000 THEN 1 ELSE 0 END) AS price_range_5').
          where(toSql(@queryTrucks))


      @estado = Truck.
          select('
          SUM(CASE WHEN estado = 0 THEN 1 ELSE 0 END) AS nuevo,
          SUM(CASE WHEN estado = 1 THEN 1 ELSE 0 END) AS usado').
          where(toSql(@queryTrucks))


      @statesPlaca = Truck.
          joins('join states on states.id = trucks.placa_state_id',).
          select('name, count(name) as total, states.link_rewrite').
          where(toSql(@queryTrucks)).
          group('name').
          order('name DESC')

    end

  end

  def camiones
    self.load_toggle({"q" => params[:q]}.to_s) #enviamos los parametros que vamos a aplilar
    @search          = Truck.where(active: 1).includes(:state).search(params[:q])
    @trucks          = @search.result.order(:nombre).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @tiposCaminiones = TypeTruck.all.includes(:sub_trucks)
    @states          = State.all.order(:name)
    @states_group    = Truck.state_group
    @modelos_group   = Truck.modelo_group
    @brand_group     = Truck.marcas_group
    @km_group        = Truck.km_group
    @toggle_search   = self.nested_search(params[:q])
  end

  def camiontipo
    id_sub           = params[:id_sub]
    id_truck         = params[:id_truck]
    @search          = Truck.where(sub_truck_id: id_sub, type_truck_id: id_truck, active: 1).includes(:state).search(params[:q])
    @trucks          = @search.result.order(:nombre).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @tiposCaminiones = TypeTruck.includes(:sub_trucks)
    @states          = State.all.order(:name)
    @states_group    = Truck.state_group
    @modelos_group  = Truck.modelo_group
    @km_group        = Truck.km_group
    @brand_group     = Truck.marcas_group
    @toggle_search   = self.nested_search(self.get_toggle)
    render :camiones 
  end

  def camion_toggle
    self.read_toggle(params['q']) #leemos el parametro para limpiar la busqueda
    @search          = Truck.where(active: 1).includes(:state).search(self.get_toggle)
    @trucks          = @search.result.order(:nombre).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @tiposCaminiones = TypeTruck.all.includes(:sub_trucks)
    @states          = State.all.order(:name)
    @states_group    = Truck.state_group
    @modelos_group   = Truck.modelo_group
    @km_group        = Truck.km_group
    @brand_group     = Truck.marcas_group
    @toggle_search = self.nested_search(self.get_toggle)
    render :camiones  
  end

  def repuestos
    self.load_toggle({"q" => params[:q]}.to_s) #enviamos los parametros que vamos a aplilar  
    @search        = Extra.where(active: 1).includes(:state, :city).search(params[:q])
    @extras        = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @type_trucks   = TypeTruck.group_by_brand
    @states        = State.all.order(:name)
    @brand_group   = Extra.brand_group
    @states_group  = Extra.state_group
    @toggle_search = self.nested_search(params[:q])
  end

  def repuestotipo
    id_brand          = params[:id_brand]
    id_truck          = params[:id_truck]
    @search           = Extra.where(brand_extra_id: id_brand, type_truck_id: id_truck, active: 1).includes(:state, :city).search(params[:q])
    @extras           = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @states           = State.all.order(:name)
    @type_trucks      = TypeTruck.group_by_brand
    @brand_group      = Extra.brand_group
    @states_group     = Extra.state_group
    @toggle_search    = self.nested_search(self.get_toggle) #le enviamos el hash de busqueda
    render :repuestos
  end

  def repuesto_toggle
    self.read_toggle(params['q']) #leemos el parametro para limpiar la busqueda
    @search        = Extra.where(active: 1).includes(:state, :city).search(self.get_toggle)
    @extras        = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @type_trucks   = TypeTruck.group_by_brand
    @states        = State.all.order(:name)
    @brand_group   = Extra.brand_group
    @states_group  = Extra.state_group
    @toggle_search = self.nested_search(self.get_toggle)
    render :repuestos
  end

  def servicios
    self.load_toggle({"q" => params[:q]}.to_s) #enviamos los parametros que vamos a aplilar  
    @search        = Service.where(active: 1).includes(:state, :city).search(params[:q])
    @services      = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @states        = State.all.order(:name)
    @type_services = TypeService.group_by_services
    @states_group  = Service.state_group
    @toggle_search = self.nested_search(params[:q])
  end

  def serviciotipo
    id             = params[:id]
    @search        = Service.where(type_service_id: id).includes(:state, :city).search(params[:q])
    @services      = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @type_services = TypeService.group_by_services
    @states        = State.all.order(:name)
    @states_group  = Service.state_group
    @toggle_search = Hash.new
    render :servicios
  end

  def service_toggle
    self.read_toggle(params['q']) #leemos el parametro para limpiar la busqueda
    @search        = Service.where(active: 1).includes(:state, :city).search(self.get_toggle)
    @services      = @search.result.order(:name).page(params[:page]).per(Environment::LIMIT_SEARCH)
    @states        = State.all.order(:name)
    @type_services = TypeService.group_by_services
    @states_group  = Service.state_group
    @toggle_search = self.nested_search(self.get_toggle) #le enviamos el hash de busqueda
    render :servicios
  end


  def camion
    @truck = Truck.find_by_id(params[:id])
    @ciudad = City.find_by_id(@truck.placa_city_id)
  end

  def servicio
    @service = Service.find_by_id(params[:id])
  end

    private

    def load_banners
       @banners = Banner.all.order('rand()').limit(3)
    end

    def validate_injection(str)
       array_str = str.split(" ")
       array_str.each do |word|
         result = Environment::ARRAYSQL[word.downcase]
         return true if result
       end
       return false
    end


    def allowed_lateUpdate_params
      params.require(:truck).permit(:id,:active,:price, customer_attributes:[:id,:telefono,:email])
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
