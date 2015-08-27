class Offer < ActiveRecord::Base


  has_many :offercustomers
  has_many :offer, through: :offercustomers



end
