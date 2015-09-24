Rails.application.routes.draw do

  root 'pages#index'

  get  'tarifas' => 'pages#tarifas'
  get  'comprar' => 'pages#comprar'
  match 'busqueda' => 'pages#busqueda', via: [:get, :post]
  get  'camion-tipo/:id_truck/:id_sub'  => 'pages#camiontipo'
  get 'camion-marca/:id_truck/:id_brand'  => 'pages#camionmarca'
  get  'repuesto-tipo/:id_truck/:id_brand' => 'pages#repuestotipo'
  get  'servicio-tipo/:id' => 'pages#serviciotipo'

  get  'mi-cuenta' => 'pages#micuenta', :as=> 'micuenta'
  post 'mi-cuenta' => 'pages#micuenta'




  get 'mi-cuenta/camiones' => 'pages#micamiones', :as=> 'micamiones'
  get 'mi-cuenta/camiones/agregar' => 'pages#micamionesnew', :as=> 'micamionesnew'
  post 'mi-cuenta/camiones/agregar' => 'pages#micamionesnew', :as=> 'micamionesnewpost'
  get 'mi-cuenta/camiones/editar/:id' => 'pages#micamionesedit', :as=> 'micamionesedit'
  post 'mi-cuenta/camiones/editar/:id' => 'pages#micamionesedit', :as=> 'micamioneseditpost'
  delete 'mi-cuenta/camiones/delete/:id' => 'pages#micamionesdelete', :as=> 'micamionesdelete'


  get 'mi-cuenta/repuestos' => 'pages#mirepuestos', :as=> 'mirepuestos'
  get 'mi-cuenta/repuestos/agregar' => 'pages#mirepuestosnew', :as=> 'mirepuestosnew'
  post 'mi-cuenta/repuestos/agregar' => 'pages#mirepuestosnew', :as=> 'mirepuestosnewpost'
  get 'mi-cuenta/repuestos/editar/:id' => 'pages#mirepuestosedit', :as=> 'mirepuestosedit'
  post 'mi-cuenta/repuestos/editar/:id' => 'pages#mirepuestosedit', :as=> 'mirepuestoseditpost'
  delete 'mi-cuenta/repuestos/delete/:id' => 'pages#mirepuestosdelete', :as=> 'mirepuestosdelete'

  get 'mi-cuenta/servicios' => 'pages#miservicios', :as=> 'miservicios'
  get 'mi-cuenta/servicios/agregar' => 'pages#miserviciosnew', :as=> 'miserviciosnew'
  post 'mi-cuenta/servicios/agregar' => 'pages#miserviciosnew', :as=> 'miserviciosnewpost'
  get 'mi-cuenta/servicios/editar/:id' => 'pages#miserviciosedit', :as=> 'miserviciosedit'
  post 'mi-cuenta/servicios/editar/:id' => 'pages#miserviciosedit', :as=> 'miservicioseditpost'
  delete 'mi-cuenta/servicios/delete/:id' => 'pages#miserviciosdelete', :as=> 'miserviciosdelete'


  get 'saveUser' => 'pages#guardarCustomer', :as=> 'saveUser'
  get 'saveMessage' => 'pages#guardarMensaje', :as=> 'saveMessage'


  get 'departamentos/:state_id' => 'pages#departamentos', :as=> 'departamentos'

  get 'marcas/:id' => 'pages#getbrands'
  get 'marcas/' => 'pages#getbrands'


  get 'marcasrespuestos/:id' => 'pages#getbrandsextra'
  get 'marcasrespuestos/' => 'pages#getbrandsextra'


  get 'servicio/:id-:link' => 'pages#servicio', :as =>'servicio'
  match 'servicios' => 'pages#servicios', via: [:get, :post]

  get 'camion/:id' => 'pages#camion', :as =>'camion'
  match 'camiones' => 'pages#camiones', via: [:get, :post]
  get 'camiones/:param1' => 'pages#camiones'
  get 'camiones/:param1/:param2' => 'pages#camiones'
  get 'camiones/:param1/:param2/:param3' => 'pages#camiones'



  get 'repuesto/:id-:link' => 'pages#repuesto', :as =>'repuesto'
  match 'repuestos' => 'pages#repuestos', via: [:get, :post]



  devise_for :users, skip: [:registrations, :confirmations]

  namespace :admin do

    get '', to: 'dashboard#index', as: '/'

   # get '/updateState/:iditem/:idstate/:type', to: 'dashboard#updatestate', as: 'updateState'
    get '/trucks/updateState/:iditem/:idstate/:type', to: 'dashboard#updatestate', as: 'updateState'
    get '/updateStateCustomer/:iditem/:idstate', to: 'dashboard#updatestatecustomer', as: 'updateStateCustomer'
    get '/removeImagen/:imagen/:idTruck', to: 'trucks#removePicture', as: 'removePicture'

    resources  :trucks,
      :brands_truck,
      :brand_extra,
      :type_extra,
      :extras,
      :type_service,
      :services,
      :colors_truck,
      :scraps_truck,
      :contracts_truck,
      :wheels_truck,
      :spaces_truck,
      :motors_truck,
      :boxes_truck,
      :transmissions_truck,
      :offers,
      :sub_trucks,
      :banners,
               :marcas_equipos_humedos,
               :tipo_carrocerias,
               :marca_carrocerias,
               :marca_volcos,
               :houses


    resources :states do
       resources :cities
    end

    resources :customers do
      resources :offerscustomers
    end

    resources :type_truck do
      resources :sub_trucks,
                :referencias
    end
    
    resources :inbox, only: [:index, :show, :destroy]

  end

  get  'servicio-opciones/:q' => 'pages#service_toggle'
  get  'repuesto-opciones/:q' => 'pages#repuesto_toggle'
  get  'camion-opciones/:q' => 'pages#camion_toggle'

  get  'servicios-opciones/:field/:value' => 'pages#servicios_ajax'
  get  'repuestos-opciones/:field/:value' => 'pages#repuestos_ajax'
  get  'camiones-opciones/:field/:value'  => 'pages#camiones_ajax'

  get 'vender-camion/:id' => 'pages#sell_truck'
  get "/estatus-camion/:id" => 'pages#status_truck'
  
  get "/inbox-cliente" => "sessions#inbox"

  

  #sessiones
  
  get "/activar-cuenta/:token" => 'sessions#active_account'
  get "/cambiar-clave/:token" => 'sessions#cambiar_clave'

  resources :sessions, only: [:index] do
    
    member do
      post :process_account
      post   :process_change
    end
    
    collection do
      post   :login
      get    :logout
      get    :registrar_usuario
      post   :crear_usuario
      match  :olvido_clave, via: [:get, :post]
    end

  end

  resources :inbox, only: [:index, :show, :destroy, :new, :create]

end
