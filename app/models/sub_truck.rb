class SubTruck < ActiveRecord::Base
  belongs_to :type_truck, dependent: :destroy
end
