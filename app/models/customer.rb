class Customer < ActiveRecord::Base

  attr_accessor :confirm_clave
  
  has_many :offercustomers
  has_many :offer, through: :offercustomers


  has_many :extras
  has_many :trucks
  has_many :services

end
