class SubTruck < ActiveRecord::Base
  belongs_to :type_truck

  scope :getByTypeTruckId,->(type) {
        where(type_truck_id: type)
        }
end
