class Extra < ActiveRecord::Base

  belongs_to :user
  belongs_to :brand_extra
  belongs_to :type_truck
  belongs_to :city
  belongs_to :state

  belongs_to :customer

  has_many :message, :foreign_key => :item


  validates_presence_of [:name, :state_id, :city_id, :brand_extra_id,:price, :phone, :address],message: 'No puede estar vacio'
  
  validates :type_truck_id, presence: true
  
  validates_uniqueness_of :name, message: ' %{value} ya se encuentra registrado'

  validates_format_of [:name, :address, :description], :with => /\A([a-zA-Z_áéíóúñ0-9\s]*$)/i ,message: "El formato no es permitido evita caracteres especiales"
  
  validates_numericality_of :price,  message: "Debe ser solo numeros"

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

  before_create :add_quantity_current

  def add_quantity_current
    quantity = Quantity.find_by(customer_id: self.customer_id)
    if quantity
      quantity.current_extras += 1
      quantity.save
    end
  end
  HUMANIZED_ATTRIBUTES = {
      :name => 'Nombre',
      :city_id => 'Ciudad',
      :city => 'Ciudad',
      :state_id => 'Departamento',
      :brand_extra_id => 'Marca',
      :brand_extra => 'Marca',
      :state => 'Departamento',
      :type_truck_id => 'Tipo',
      :price => 'Precio',
      :phone => 'Telefono',
      :address => 'Direccion',
      :description => 'Description',
      :price       => 'precio'

  }
    def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end



  scope :like_join, ->(str){
    self.joins("LEFT JOIN brand_extras ON brand_extras.id = extras.brand_extra_id
                LEFT JOIN type_trucks  ON type_trucks.id =  extras.type_truck_id").
         where("extras.name LIKE '%#{str}%' OR
                brand_extras.name LIKE '%#{str}%' OR
                type_trucks.name LIKE '%#{str}%' AND
                extras.active = 1").uniq
  }

  scope :state_group, ->{
       self.select('extras.id, extras.name, extras.state_id,
                    count(extras.state_id) as total,
                    states.name as state_name').
            joins(:state).group('states.name').
            order('states.name DESC')

  }

  scope :brand_group, ->{
     self.select('extras.id, extras.name, extras.brand_extra_id,
              count(extras.brand_extra_id) as total,
              brand_extras.name as brand_name').
      joins(:brand_extra).group('brand_extras.name').
      order('brand_extras.name DESC')
  }

end
