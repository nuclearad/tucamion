class Customer < ActiveRecord::Base

  attr_accessor :clave_confirmation
  
  has_many :offercustomers
  has_many :offer, through: :offercustomers
  has_many :extras
  has_many :trucks
  has_many :services

  validates_presence_of       :cedula,   message: "El documento de identidad es un campo obligatorio"
  validates_presence_of       :name,     message: "El nombre es un campo obligatorio"
  validates_presence_of       :telefono, message: "El telefono es un campo obligatorio"
  validates_presence_of       :email,    message: "El correo es un campo obligatorio"
  validates_confirmation_of   :clave,    message: "Las contraseñas no son iguales"

  validates :clave_confirmation, presence: true
  validates :name, length:     { minimum: 5,  maximum: 50 ,   message: "El nombre debe tener minimo 5 y maximo 50 caracteres" }
  validates :telefono, length: { minimum: 13,  maximum: 14 ,   message: "El formato indicado del telefono (xxx)-xxx-xxxx" }
  validates :cedula, length:   { maximum: 13 ,  message: "El documento de identidad debe tener minimo maximo 13 caracteres" }
  validates :clave, length:    { in: 6..10 ,   message: "La contraseña debe tener minimo 6 y maximo 10 caracteres" }

  validates_uniqueness_of     :email,    message: "El correo electronico ya esta registrado"
  validates_uniqueness_of     :cedula,   message: "El documento de identidad  ya esta registrado"
  
  #jonathanse compara para ver si el usuario tiene un plan activo gratis o no 

  def cargar_planes
    begin
     offer = self.offer.find_by(typeoffer: Environment::TYPE[:planes][:gratis])
     if offer
       if self.comparar_fecha(3.months)
         return 1
       else
         return -1
       end
     else
       return self.offercustomers.siz
     end
    rescue Exception => e
       return 0
    end
  end

  def comparar_fecha(meses)
      if (self.created_at + meses) > Time.now
        true
      else
        false
      end
  end

end
