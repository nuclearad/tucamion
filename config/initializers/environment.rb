class Environment
    
    LIMIT_SEARCH  = 20

    ARRAYSQL      = {'delete' => 'delete', 'select' => 'select',
    	               'insert' => 'insert', 'from'   =>   'from',
    	               'count'  => 'count',  'max'    =>    'max',
    	               'sum'    => 'sum',    'update' => 'update'}

    TRUCK_LATE_UPDATE=10
    TRUCK_AVAILABLES_DAYS=60
    EXTRA_LATE_UPDATE=10
    EXTRA_AVAILABLES_DAYS=180

    STATUS = {clientes:  {activo: 1, inactivo: 0, eliminado: -1},
              camiones:  {activo: 1, vendido: 2, inactivo: 0, eliminado: -1, inactivo_admin: 3},
              repuestos: {activo: 1, vendido: 2, inactivo: 0, eliminado: -1, inactivo_admin: 3},
              servicios: {activo: 1, vendido: 2, inactivo: 0, eliminado: -1, inactivo_admin: 3},
              generico:  {activo: 1, vendido: 2, inactivo: 0, eliminado: -1, inactivo_admin: 3},
              mensajes:  {activo: 1, inactivo: 0, eliminado: -1}
             }


    TYPE   = {clientes: {normal: 0, revendedor: 1},
              planes:   {pago: 0, promocional: 1, generico: 2}
             }
  HORARIOS = {'8:00 am - 5:00 pm' => 1,'8:00 am - 12:00 m' => 2,'2:00 pm - 6:00 pm' => 3,'24 horas' => 4,'otro' => 5}
 
  CAPACIDAD_CARGA = {'0-5' => '0-5', '5-10' => '5-10',  '10-15' => '10-15',  '15-25' => '15-25', '25- 35' => '25- 35'}

  ESTADO_LLANTAS = { '0' => 'Excelente', '1' => 'Bueno', '2' => 'Regular', '3' => 'Malo'}

  AUTOCARPADO = { '0' => 'Automatica', '1' =>'Manual', '2' => 'No tiene'}
  
  if Rails.env.production?
    MAILSETTING = {:address              =>  'smtp.zoho.com',
                   :port                 =>  587,
                   :domain               =>  'zoho.com',
                   :user_name            =>  'info@camion365.com',
                   :password             =>  'infoinfo123',
                   :authentication       =>  'plain',
                   :enable_starttls_auto =>  true}

    APIKEY      = '2ROTuo8TSnyglaS9Bxn7FJwG19'
    MERCHANTID  = '534372'
    CURRENCY    = 'COP'
    ACCOUNTID   = '536329'
    URL_GATEWAY = 'https://gateway.payulatam.com/ppp-web-gateway'
  
  else
    MAILSETTING = {:address              =>  'smtp.gmail.com',
                   :port                 =>  587,
                   :domain               =>  'localhost',
                   :user_name            =>  'tucamionsoporte@gmail.com',
                   :password             =>  'tucamionsoporte2',
                   :authentication       =>  'plain',
                   :enable_starttls_auto =>  true}  
  

    #APIKEY      = '6u39nqhq8ftd0hlvnjfs66eh8c'
    #MERCHANTID  = '500238'
    #CURRENCY    = 'COP'
    #ACCOUNTID   = '500537'
    #URL_GATEWAY = 'https://stg.gateway.payulatam.com/ppp-web-gateway'

    APIKEY      = '2ROTuo8TSnyglaS9Bxn7FJwG19'
    MERCHANTID  = '534372'
    CURRENCY    = 'COP'
    ACCOUNTID   = '536329'
    URL_GATEWAY = 'https://gateway.payulatam.com/ppp-web-gateway'

  end

end