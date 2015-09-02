class TypeTruck < ActiveRecord::Base
  has_many :trucks
  has_many :sub_trucks
  has_many :extras
  has_many :brand_extra, through: :extras
  
  #new relation jonathan rojas
  has_many :brand_extras, through: :extras

  HUMANIZED_ATTRIBUTES = {
      :name => 'Nombre'
  }


  validates :name, presence: true

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end



  before_create do

    self.link_rewrite = self.name.downcase
    self.link_rewrite = I18n.transliterate(self.link_rewrite)

    if self.name.count(' ') >= 1
      self.link_rewrite = self.link_rewrite.gsub! ' ', '-'
    end

  end


  before_update do

    self.link_rewrite = self.name.downcase
    self.link_rewrite = I18n.transliterate(self.link_rewrite)

    if self.name.count(' ') >= 1
      self.link_rewrite = self.link_rewrite.gsub! ' ', '-'
    end

  end



end
