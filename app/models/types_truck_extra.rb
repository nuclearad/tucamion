class TypesTruckExtra < ActiveRecord::Base
  belongs_to :extra
  belongs_to :type_truck
end
