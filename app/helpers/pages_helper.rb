module PagesHelper

   def calculuarPrecio index
     if session[:user].nil?
       number_to_currency @planes[index].precio1, precision: 0
    else
       if @user.typeuser == 0
         number_to_currency @planes[index].precio1, precision: 0
       else
         number_to_currency @planes[index].precio2, precision: 0
       end
     end
   end

end
