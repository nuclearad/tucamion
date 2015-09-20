class ScrapsTruck < ActiveRecord::Base

  has_many :truck, dependent: :destroy

  validates :name, presence: true

  HUMANIZED_ATTRIBUTES = {
      :name => 'Nombre'
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end



end
