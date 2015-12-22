module ApplicationHelper
   include GlobalMethods
   
   def currency_colombia(price)
     number_to_currency price , unit: "$", separator: ",", delimiter: "."
   end

end
