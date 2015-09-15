class Offercustomer < ActiveRecord::Base

  belongs_to :customer
  belongs_to :offer

  after_create :add_quanties

  def add_quanties
  	quantity = Quantity.find_by(customer_id: self.customer_id)
  	plan = Offer.find(self.offer_id)
    if quantity
      quantity.total_trucks   += plan.trucks.to_i
      quantity.total_extras   += plan.extra.to_i
      quantity.total_services += plan.service.to_i
      quantity.save
    else
      Quantity.create(customer_id: self.customer_id, total_services: plan.service,
                      total_extras: plan.extra, total_trucks: plan.trucks)
    end
  end

end
