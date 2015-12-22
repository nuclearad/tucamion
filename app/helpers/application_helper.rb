module ApplicationHelper
   include GlobalMethods
   
   def currency_colombia(price)
     number_to_currency price , unit: "$", separator: ",", delimiter: "."
   end
   
   def missing_image(value)
   	  if value
   	    return value
   	  else
   	  	return '01.jpg'
   	  end
   end

end
