class Customer < ActiveRecord::Base

  attr_accessor :clave_confirmation


  has_many :offercustomers, dependent: :destroy
  has_many :offer, through: :offercustomers
  has_many :extras, dependent: :destroy
  has_many :trucks, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :quantities, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates_presence_of       :cedula,   message: "El documento de identidad es un campo obligatorio"
  validates_presence_of       :name,     message: "El nombre es un campo obligatorio"
  validates_presence_of       :telefono, message: "El telefono es un campo obligatorio"
  validates_presence_of       :email,    message: "El correo es un campo obligatorio"
  validates_format_of         :email,    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: [:create,:update], message:'El formato de correo electronico es invalido'
  validates_confirmation_of   :clave,    message: "Las contraseñas no son iguales", on: :create

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ,    message: "El formato del correo no es permitido"

  validates_format_of :name, :with => /\A([a-zA-Z_áéíóúñ\s]*$)/i ,message: "Deben ser solo letras"

  validates :clave_confirmation, presence: true, on: [:create, :cambiar_clave_by_Id]
  validates :name, length:     { minimum: 5,  maximum: 50 ,   message: "El nombre debe tener minimo 5 y maximo 50 caracteres" }

  validates :cedula, length:   { maximum: 13 ,  message: "El documento de identidad debe tener minimo maximo 13 caracteres" }
  validates :clave, length:    { in: 6..10 ,   message: "La contraseña debe tener minimo 6 y maximo 10 caracteres" }, on: :create

  validates_uniqueness_of     :email,    message: "El correo electronico ya esta registrado"
  validates_uniqueness_of     :cedula,   message: "El documento de identidad  ya esta registrado"

  validates :telefono, length: { minimum: 7,  maximum: 11 ,   message: "El telefono debe contener entre 7 caracteres y 11 caracteres" }
  validates_numericality_of :telefono,  message: "Debe ser solo numeros"

  accepts_nested_attributes_for :quantities , allow_destroy: true
  accepts_nested_attributes_for :offer

  before_create :password_digest
  #before_process_change :password_digest
  #jonathanse compara para ver si el usuario tiene un plan activo gratis o no

  def password_digest
    self.clave = BCrypt::Password.create(self.clave)
  end

  def is_password?(password)
    logger.info 'en model' +password
    BCrypt::Password.new(self.clave) == password
  end

  def cargar_planes
    begin
     offer = self.offer.find_by(typeoffer: Environment::TYPE[:planes][:promocional])
     if offer
       if self.comparar_fecha(3.months)
         return 1
       else
         return -1
       end
     else
       return self.offercustomers.size
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

  def messages_no_leidos
    self.messages.where(:status => 1)
  end

  def list_messages
    self.messages.includes(:truck, :service, :extra).order("status DESC, tipo, created_at DESC")
  end

end
