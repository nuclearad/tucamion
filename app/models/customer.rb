class Customer < ActiveRecord::Base


  has_many :offercustomers
  has_many :offer, through: :offercustomers


  has_many :extras
  has_many :trucks
  has_many :services

end
