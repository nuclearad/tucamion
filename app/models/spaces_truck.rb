class SpacesTruck < ActiveRecord::Base

  has_many :truck, dependent: :destroy


  validates :name, presence: true

  HUMANIZED_ATTRIBUTES = {
      :name => 'Tipo cupo',


  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end



end
