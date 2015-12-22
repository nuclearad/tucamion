module PagesHelper

   def calculuarPrecio index
     if current_customer.nil?
       number_to_currency @planes[index].precio1, precision: 0
    else
       if @user.typeuser == 0
         number_to_currency @planes[index].precio1, precision: 0
       else
         number_to_currency @planes[index].precio2, precision: 0
       end
     end
   end

   def calculuarPrecio2
       if @user.typeuser == 0
         number_to_currency @plan.precio1, precision: 0
       else
         number_to_currency @plan.precio2, precision: 0
       end
   end

   def calcular_precio_pago
       if @user.typeuser == 0
         @plan.precio1
       else
         @plan.precio2
       end
   end

end
