class Service < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  belongs_to :state
  belongs_to :customer
  
  has_many :services_type_services
  has_many :type_services, through: :services_type_services
  has_many :messages, :foreign_key => :item

  accepts_nested_attributes_for :type_services

  validates_uniqueness_of :name, message: ' %{value} ya se encuentra registrado'
  validates_presence_of [:nit, :name, :phone, :state_id, :address, :email], message: 'No puede estar vacio'
 
  validates_format_of [:nit, :name, :description], :with => /\A([a-zA-Z_áéíóúñ0-9\s]*$)/i ,message: "El formato no es permitido evita caracteres especiales"

  validates_format_of [:address], :with => /\A([a-zA-Z_áéíóúñ0-9#()-.\s]*$)/i ,message: "El formato no es permitido evita caracteres especiales solo se permite eluso de: #.()-"
 
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ,  message: "Debe poseer un formato valido"
  
  validates :nit, length: {maximum: 15 ,   message: "El NIT tiene un maximo de 15 caracteres" }

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

  validates :phone, length: { minimum: 7,  maximum: 11 ,   message: "El telefono debe contener entre 7 caracteres y 11 caracteres" }
  validates_numericality_of :phone,  message: "Debe ser solo numeros"
  
  HUMANIZED_ATTRIBUTES = {
      :name => 'Nombre',
      :phone => 'Telefono',
      :type_service_id => 'Tipo de Servicio',
      :state_id => 'Departamento',
      :address => 'Dirreccion',
      :description => 'Descripcion'
  }
  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


  after_rollback :print_error

  def print_error
    puts self.errors.full_messages
    puts "*****************"
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

  before_create :add_quantity_current

  def add_quantity_current
    quantity = Quantity.find_by(customer_id: self.customer_id)
    if quantity
      quantity.current_services += 1
      quantity.save
    end
  end

  scope :like_join, ->(str){
    self.joins("LEFT JOIN services_type_services ON services_type_services.service_id = services.id
                LEFT JOIN type_services ON type_services.id = services_type_services.type_service_id ").
         where("(services.name LIKE '%#{str}%' OR
                type_services.name LIKE '%#{str}%') AND
                services.active = 1").uniq
  }

  scope :state_group, ->{
       self.select('services.id, services.name, services.state_id,
                    count(services.state_id) as total,
                    states.name as state_name').
            joins(:state).group('states.name').
            where("services.active = 1").
            order('states.name DESC')

  }

  scope :test_load_services, ->{
    results = self.where(:active => 3)
    if results.size > 0
      results.each do |result|
        result.active = 1
        result.save
        puts '**************inicio******************'
        puts "se cambio el registro #{result.name}"
        puts '**************************************'
      end
    else
      puts '**************inicio******************'
      puts 'No se encuentran registros'
      puts '**************************************'
    end
  }

end
