class Extra < ActiveRecord::Base


  belongs_to :brand_extra
  belongs_to :type_truck
  belongs_to :city
  belongs_to :state

  belongs_to :customer

  has_many :messages, -> { where(tipo: 2)}, :foreign_key => :item


  validates :name, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :brand_extra_id, presence: true
  validates :type_truck_id, presence: true




  has_attached_file :picture1, :styles => {:home => '548x300>', :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  validates_attachment_content_type :picture1, :content_type => /\Aimage\/.*\Z/


  has_attached_file :picture2, :styles => {:home => '548x300>', :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  validates_attachment_content_type :picture2, :content_type => /\Aimage\/.*\Z/

  has_attached_file :picture3, :styles => {:home => '548x300>', :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  validates_attachment_content_type :picture3, :content_type => /\Aimage\/.*\Z/

  has_attached_file :picture4, :styles => {:home => '548x300>', :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  validates_attachment_content_type :picture4, :content_type => /\Aimage\/.*\Z/

  has_attached_file :picture5, :styles => {:home => '548x300>', :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  validates_attachment_content_type :picture5, :content_type => /\Aimage\/.*\Z/



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

  scope :like_join, ->(str){
    self.where("extras.name LIKE '%#{str}%' OR
                brand_extras.name LIKE '%#{str}%' OR
                type_trucks.name LIKE '%#{str}%' AND
                extras.active = 1")
  }

  scope :state_group, ->{
       self.select('extras.id, extras.name, 
                    count(extras.state_id) as total, 
                    states.name as state_name').
            joins(:state).group('states.name').
            order('states.name DESC')
  
  }

  scope :brand_group, ->{
     self.select('extras.id, extras.name, 
              count(extras.brand_extra_id) as total, 
              brand_extras.name as brand_name').
      joins(:brand_extra).group('brand_extras.name').
      order('brand_extras.name DESC')
  }

end
