class Environment
  LIMIT_SEARCH  = 4
  ARRAYSQL      = {'delete' => 'delete', 'select' => 'select', 
  	               'insert' => 'insert', 'from'   =>   'from', 
  	               'count'  => 'count',  'max'    =>    'max',
  	               'sum'    => 'sum',    'update' => 'update'}

  TRUCK_LATE_UPDATE=10
  TRUCK_AVAILABLES_DAYS=60
  EXTRA_LATE_UPDATE=10
  EXTRA_AVAILABLES_DAYS=180

  STATUS = {clientes:  {activo: 1, inactivo: 0, eliminado: -1},
            camiones:  {activo: 1, vendido: 2, inactivo: 0, eliminado: -1},
            repuestos: {activo: 1, vendido: 2, inactivo: 0, eliminado: -1},
            servicios: {activo: 1, vendido: 2, inactivo: 0, eliminado: -1}
           }
  
  
  TYPE   = {clientes: {normal: 0, revendedor: 1},
            planes:   {pago: 0, gratis: 1}
           }

end