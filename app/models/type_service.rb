class TypeService < ActiveRecord::Base
  
  has_many :services_type_services
  has_many :services, through: :services_type_services

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

  scope :group_by_services, ->(){
    self.select('type_services.id,
                 type_services.name, 
                 COUNT(services.type_service_id) as total').
         joins(:services).
         group('type_services.id')
  }

end
