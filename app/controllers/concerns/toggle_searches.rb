module ToggleSearches
  extend ActiveSupport::Concern
  
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
      
end