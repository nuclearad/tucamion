class ServicesTypeService < ActiveRecord::Base
  belongs_to :service
  belongs_to :type_service
end
