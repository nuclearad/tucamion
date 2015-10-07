module ToggleSearches
  extend ActiveSupport::Concern
  include ActionView::Helpers::NumberHelper
  
  def init_toggle
    session[:toggle_search] = nil
  end
  
  def load_toggle options
    session[:toggle_search] = options
    puts "******#{session[:toggle_search]}**************" 
  end

  def read_toggle option
    puts "******#{session[:toggle_search]}**************"
    if option
      puts "*******************#{option}*************************"
      session[:toggle_search] = eval(session[:toggle_search]) if session[:toggle_search]["q"].class.to_s == 'String'
      session[:toggle_search]['q'][option] = ""
    end
    puts "******#{session[:toggle_search]["q"]}**************" 
  end

  def get_toggle
    session[:toggle_search]['q']
  end
 
  def nested_search(query)
    array_searches = Array.new
    if query

      #search for trucks

      unless query["brand_truck_id_eq"].blank?
        search                      = Array.new
        search[0]                   = BrandTruck.select("id,name").find(query["brand_truck_id_eq"]).name
        query["brand_truck_id_eq"] = ""
        search[1]                   = "brand_truck_id_eq"
        array_searches << search
      end

      unless query["capacidadcarga_eq"].blank?
        search     = Array.new
        search[0]  = "Capacidad de carga: #{query['capacidadcarga_eq']}"
        search[1]  = "capacidadcarga_eq"
        array_searches << search
      end
      
      unless query["referencia_id_eq"].blank?
        search                      = Array.new
        search[0]                   = Referencia.select("id,name").find(query["referencia_id_eq"]).name
        query["referencia_id_eq"] = ""
        search[1]                   = "referencia_id_eq"
        array_searches << search
      end
      #search for extras
      
      unless query["type_truck_id_eq"].blank?
        search     = Array.new
        search[0]  = TypeTruck.select("id,name").find(query["type_truck_id_eq"]).name
        search[1]  = "type_truck_id_eq"
        array_searches << search
      end
      unless query["brand_extras_id_eq"].blank?
        search     = Array.new
        search[0]  = BrandExtra.select("id,name").find(query["brand_extras_id_eq"]).name
        search[1]  = "brand_extras_id_eq"
        array_searches << search
      end
      unless query["price_gteq"].blank?
        search     = Array.new
        search[0]  = "precio 1: #{number_to_currency(query['price_gteq'], precision: 0)}"
        search[1]  = "price_gteq"
        array_searches << search
      end
      unless query["price_lteq"].blank?
        search     = Array.new
        search[0]  = "precio 2: #{number_to_currency(query['price_lteq'], precision: 0)}"
        search[1]  = "price_lteq"
        array_searches << search
      end
      
      #search for services
      unless query["type_services_id_eq"].blank?
        search                      = Array.new
        search[0]                   = TypeService.select("id,name").find(query["type_services_id_eq"]).name
        query["type_services_id_eq"] = ""
        search[1]                   = "type_services_id_eq"
        array_searches << search
      end

      #search shared
      unless query["state_id_eq"].blank?
        search               = Array.new
        search[0]            =  State.select("id,name").find(query["state_id_eq"]).name
        query["state_id_eq"] = ""
        search[1]            = "state_id_eq" 
        array_searches << search
      end
      unless query["name_cont"].blank?
        search     = Array.new
        search[0]  = query["name_cont"]
        search[1]  = "name_cont"
        array_searches << search
      end
      unless query["nombre_cont"].blank?
        search     = Array.new
        search[0]  = query["nombre_cont"]
        search[1]  = "nombre_cont"
        array_searches << search
      end
    end
    return array_searches
  end


end