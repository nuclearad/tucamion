class ContractsTruck < ActiveRecord::Base

  has_many :truck


  validates :name, presence: true

  HUMANIZED_ATTRIBUTES = {
      :name => 'Nombre de la poliza'
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end



end
