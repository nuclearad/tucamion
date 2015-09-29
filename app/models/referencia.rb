class Referencia < ActiveRecord::Base

  self.table_name = 'referencias'

  has_many :trucks, dependent: :destroy


  HUMANIZED_ATTRIBUTES = {
      :name => 'Nombre'
  }


  validates :name, presence: true

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


  scope :getByTypeTruckId, ->(type){
  select(:name,:id).where(type_truck_id: type)
  }

end
