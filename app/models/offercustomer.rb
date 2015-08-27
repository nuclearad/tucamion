class Offercustomer < ActiveRecord::Base

  belongs_to :customer
  belongs_to :offer

end
