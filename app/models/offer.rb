class Offer < ActiveRecord::Base


  has_many :offercustomers, dependent: :destroy
  has_many :offer, through: :offercustomers
  
  has_many :payments


end
