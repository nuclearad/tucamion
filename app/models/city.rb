class City < ActiveRecord::Base
  belongs_to :state
  has_many :trucks, dependent: :destroy
  has_many :services, dependent: :destroy


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
  scope :getByState, ->(state_id){
    select(:name,:id).where(state_id: state_id)
  }

end
