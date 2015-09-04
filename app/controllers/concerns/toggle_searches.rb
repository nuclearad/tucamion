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
      new_hash = eval(option)
      puts "*******************#{new_hash.keys[0]}*************************"
      session[:toggle_search] = eval(session[:toggle_search]) if session[:toggle_search]["q"].class.to_s == 'String'
      session[:toggle_search]['q'][new_hash.keys[0]] = ""
    end
    puts "******#{session[:toggle_search]["q"]}**************" 
  end

  def get_toggle
    session[:toggle_search]['q']
  end
 
  def nested_search(query)
    array_searches = Array.new
    if query
      #search for extras
      
      unless query["type_truck_id_eq"].blank?
        search     = Array.new
        search[0]  = TypeTruck.select("id,name").find(query["type_truck_id_eq"]).name
        search[1]  = {"type_truck_id_eq" => ""}
        array_searches << search
      end
      unless query["brand_extra_id_eq"].blank?
        search     = Array.new
        search[0]  = BrandExtra.select("id,name").find(query["brand_extra_id_eq"]).name
        search[1]  = {"brand_extra_id_eq" => ""}
        array_searches << search
      end
      unless query["price_gteq"].blank?
        search     = Array.new
        search[0]  = "precio 1: #{number_to_currency(query['price_gteq'], precision: 0)}"
        search[1]  = {"price_gteq" => ""}
        array_searches << search
      end
      unless query["price_lteq"].blank?
        search     = Array.new
        search[0]  = "precio 2: #{number_to_currency(query['price_lteq'], precision: 0)}"
        search[1]  = {"price_lteq" => ""}
        array_searches << search
      end
      
      #search for services
      unless query["type_service_id_eq"].blank?
        search                      = Array.new
        search[0]                   = TypeService.select("id,name").find(query["type_service_id_eq"]).name
        query["type_service_id_eq"] = ""
        search[1]                   = {"type_service_id_eq" => ""}
        array_searches << search
      end

      #search shared
      unless query["state_id_eq"].blank?
        search               = Array.new
        search[0]            =  State.select("id,name").find(query["state_id_eq"]).name
        query["state_id_eq"] = ""
        search[1]            = {"state_id_eq" => ""}
        array_searches << search
      end
      unless query["name_cont"].blank?
        search     = Array.new
        search[0]  = query["name_cont"]
        search[1]  = {"name_cont" => ""}
        array_searches << search
      end
    end
    return array_searches
  end


end