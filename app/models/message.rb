class Message < ActiveRecord::Base

  belongs_to :truck, :foreign_key => :item
  belongs_to :extra, :foreign_key => :item
  belongs_to :service, :foreign_key => :item
  belongs_to :user
  belongs_to :customer
  
  validates_presence_of       :nombre,     message: "El nombre es un campo obligatorio"
  validates_presence_of       :telefono, message: "El telefono es un campo obligatorio"
  validates_presence_of       :mensaje,    message: "El mensaje es un campo obligatorio"
  validates_format_of         [:nombre, :mensaje], :with => /\A([a-zA-Z_áéíóúñ0-9\s]*$)/i ,message: "No debe tener caracteres especiales"
  validates :mensaje, length: { minimum: 10,  maximum: 500 ,   message: "El mensaje debe tener un minimo de 10 y un maximo de 500 caracteres" }
  validates :nombre, length:     { minimum: 5,  maximum: 50 ,   message: "El nombre debe tener minimo 5 y maximo 50 caracteres" }
  validates :telefono, length: { minimum: 13,  maximum: 14 ,   message: "El formato indicado del telefono (xxx)-xxx-xxxx" }
 
end
