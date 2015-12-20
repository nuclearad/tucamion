class ApplicationController < ActionController::Base
  include ToggleSearches, GlobalMethods
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource


  protected

    def layout_by_resource
      if devise_controller?
        'devise'
      end
    end

  def same_user_admin_id

    if(self.current_customer.to_s == params[:id])
      return true
    else
      redirect_to micuenta_path and return
    end
  end

  def same_user_id
    if (self.current_customer.to_s == params[:id])
      return true
    else
      logger.info "*********** Original: #{session[:user].to_s} params: #{params[:id]} ************"
      redirect_to micuenta_path and return
    end
  end

  def toUrl(vars)
    url = ''
    cuenta = 0
    if vars.count > 1
      vars.each do |var|
        if(cuenta==0)
          url += var+'_'
        else
          if vars.count != cuenta
            url += var+'_'
          else
            url += var
          end

        end
        cuenta = cuenta+1
      end
    else
      url = vars[0]
    end
   if url[url.length-1] == '_'
     n = url.length-2
     url = url.slice(0..n)
   end
   url
  end

  def removerParametroPrincipal(url, parametro)


    url = url.sub(parametro, '')




    if url.scan('//').count >= 2


      cuenta = 1
      newUrl = ''
      url.split('//').each do |item|

        if cuenta == 1
          newUrl += item+'//'

        else


          if url.split('//').count == cuenta
            newUrl += item
          else
            newUrl += item+'/'
          end


        end
        cuenta = cuenta +1
      end
      url = newUrl

    end


    url

  end


  def removerParametroPrincipal2(url, parametro)
    if parametro.include? '_'

      parametro =  '/'+extraigoParametroprincicpal(parametro) + '_'
      url.gsub! parametro, '_'

    else
      url.gsub! parametro+'/', ''

    end




  end


  def agregarParametroPrincipal(url, parametro, slash)

    urlExplode = url.split('_')
    if slash
      newUrl = urlExplode[0]+'/'+parametro
    else
      newUrl = urlExplode[0]+parametro
    end




    cuenta = 0

    urlExplode.each do |item|

      if cuenta > 0

        if cuenta != urlExplode.count
          newUrl += '_'+item
        else

        end
      end

      cuenta = cuenta+1

    end
     newUrl



  end


  def agregarParametroSegundarios(url, llave, valor, slash)

    if slash
      if url.include? ('_')
        url += ''
      else
        url += '/'
      end


    end

    if url.include? '_'
      url += '_'+llave+'_'+valor
    else
      url += '_'+llave+'_'+valor
    end
    url

  end




  def extraigoParametroprincicpal(parametro)

    if parametro.include? '_'
      parametro = parametro.split('_')
      parametro[0]
    else
      parametro
    end

  end



  helper_method :toUrl, :removerParametroPrincipal, :agregarParametroPrincipal, :agregarParametroSegundarios, :extraigoParametroprincicpal, :removerParametroPrincipal2

end
