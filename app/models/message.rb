class Message < ActiveRecord::Base

  belongs_to :truck
  belongs_to :extra
  belongs_to :service
  belongs_to :user
  belongs_to :customer
  
  validates_presence_of       :nombre,     message: "El nombre es un campo obligatorio"
  validates_presence_of       :telefono, message: "El telefono es un campo obligatorio"
  validates_presence_of       :mensaje,    message: "El mensaje es un campo obligatorio"
  
  validates :nombre, length:     { minimum: 5,  maximum: 50 ,   message: "El nombre debe tener minimo 5 y maximo 50 caracteres" }
  validates :telefono, length: { minimum: 13,  maximum: 14 ,   message: "El formato indicado del telefono (xxx)-xxx-xxxx" }
 
end
