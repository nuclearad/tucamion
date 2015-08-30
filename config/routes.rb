Rails.application.routes.draw do





  root 'pages#index'

  get 'tarifas' => 'pages#tarifas'
  get 'comprar' => 'pages#comprar'
  get 'busqueda' => 'pages#busqueda'
  get 'camion-tipo/:id' => 'pages#camiontipo'


  get 'mi-cuenta' => 'pages#micuenta', :as=> 'micuenta'
  post 'mi-cuenta' => 'pages#micuenta'




  get 'mi-cuenta/camiones' => 'pages#micamiones', :as=> 'micamiones'
  get 'mi-cuenta/camiones/agregar' => 'pages#micamionesnew', :as=> 'micamionesnew'
  post 'mi-cuenta/camiones/agregar' => 'pages#micamionesnew', :as=> 'micamionesnewpost'
  get 'mi-cuenta/camiones/editar/:id' => 'pages#micamionesedit', :as=> 'micamionesedit'
  post 'mi-cuenta/camiones/editar/:id' => 'pages#micamionesedit', :as=> 'micamioneseditpost'



  get 'mi-cuenta/repuestos' => 'pages#mirepuestos', :as=> 'mirepuestos'
  get 'mi-cuenta/repuestos/agregar' => 'pages#mirepuestosnew', :as=> 'mirepuestosnew'
  post 'mi-cuenta/repuestos/agregar' => 'pages#mirepuestosnew', :as=> 'mirepuestosnewpost'
  get 'mi-cuenta/repuestos/editar/:id' => 'pages#mirepuestosedit', :as=> 'mirepuestosedit'
  post 'mi-cuenta/repuestos/editar/:id' => 'pages#mirepuestosedit', :as=> 'mirepuestoseditpost'


  get 'mi-cuenta/servicios' => 'pages#miservicios', :as=> 'miservicios'
  get 'mi-cuenta/servicios/agregar' => 'pages#miserviciosnew', :as=> 'miserviciosnew'
  post 'mi-cuenta/servicios/agregar' => 'pages#miserviciosnew', :as=> 'miserviciosnewpost'
  get 'mi-cuenta/servicios/editar/:id' => 'pages#miserviciosedit', :as=> 'miserviciosedit'
  post 'mi-cuenta/servicios/editar/:id' => 'pages#miserviciosedit', :as=> 'miservicioseditpost'









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
  get 'camiones' => 'pages#camiones'
  get 'camiones/:param1' => 'pages#camiones'
  get 'camiones/:param1/:param2' => 'pages#camiones'
  get 'camiones/:param1/:param2/:param3' => 'pages#camiones'



  get 'repuesto/:id-:link' => 'pages#repuesto', :as =>'repuesto'
  get 'repuestos' => 'pages#repuestos'
  get 'repuestos/:param1' => 'pages#repuestos'
  get 'repuestos/:param1/:param2' => 'pages#repuestos'
  get 'repuestos/:param1/:param2/:param3' => 'pages#repuestos'



  devise_for :users

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





  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
