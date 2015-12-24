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

   def spanish_month(month)
     hash = {'December' => 'Diciembre', 'January'   => 'Enero',
             'Febrary'  => 'Febrero',   'Marzo'     => 'Marzo',
             'April'    => 'Abril',     'May'       => 'Mayo',
             'June'     => 'Junio',     'July'      => 'Julio',
             'August'   => 'Agosto',    'September' => 'Septiembre',
             'October'  => 'Octubre',   'November'  => 'Noviembre'}
     return hash[month.to_s]
   end
end
