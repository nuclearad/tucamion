class Extra < ActiveRecord::Base

  belongs_to :user

  belongs_to :city
  belongs_to :state

  has_many :extras_brands_extras
  has_many :brand_extras, through: :extras_brands_extras

  belongs_to :customer

  has_many :messages, :foreign_key => :item
  
  has_many :types_truck_extras
  has_many :type_trucks, through: :types_truck_extras

  accepts_nested_attributes_for :brand_extras
  
  accepts_nested_attributes_for :type_trucks

  validates_presence_of [:nit, :name, :state_id, :city_id, :phone, :address,:email],message: 'No puede estar vacio'

  validates_uniqueness_of :name, message: ' %{value} ya se encuentra registrado'

  validates_format_of [:name, :nit, :description], :with => /\A([a-zA-Z_áéíóúñ0-9\s]*$)/i ,message: "El formato no es permitido evita caracteres especiales"
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
      :phone => 'Telefono',
      :address => 'Direccion',
      :description => 'Descripcion'
  }
    def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end



  scope :like_join, ->(str){
    self.joins("LEFT JOIN extras_brands_extras ON extras_brands_extras.extra_id = extras.id
                LEFT JOIN brand_extras ON brand_extras.id = extras_brands_extras.brand_extra_id
                LEFT JOIN types_truck_extras ON types_truck_extras.extra_id = extras.id
                LEFT JOIN type_trucks  ON type_trucks.id =  types_truck_extras.type_truck_id").
         where("(extras.name LIKE '%#{str}%' OR
                brand_extras.name LIKE '%#{str}%' OR
                type_trucks.name LIKE '%#{str}%') AND
                extras.active = 1").uniq
  }

  scope :state_group, ->{
       self.select('extras.id, extras.name, extras.state_id,
                    count(extras.state_id) as total,
                    states.name as state_name').
            joins(:state).group('states.name').
            where("extras.active = 1").
            order('states.name DESC')

  }

  scope :brand_group, ->{
     self.select('extras.id, extras.name, brand_extras.id as brand_id,
              count(brand_extras.id) as total,
              brand_extras.name as brand_name').
      joins(:brand_extras).
      where("extras.active = 1").
      group('brand_extras.name').
      order('brand_extras.name DESC')
  }

  scope :expired, ->(val){
    begin
      extras = Extra.where('updated_at <= ? AND active=?', 
                                Time.now - val.months,  
                                Environment::STATUS[:repuestos][:activo])
      if extras.size > 0
         extras.each do |extra|
           extra.active = Environment::STATUS[:repuestos][:inactivo_admin]
           extra.save
           Customer::CustomerMailer.inactive_extra_for_system(extra).deliver
           puts '**************Metodo expired extras******************'
           puts "Fecha de ejecucion: #{Time.now.strftime('%B %d del %Y %H:%M:%S')}"
           puts "El sistema deshabilita el servicio #{extra.name} fecha de activacion #{extra.updated_at.strftime('%B %d del %Y')}"
           puts '************Fin del proceso***********************'   
         end
         system("exec sync && sysctl -w vm.drop_caches=3")
      else
        puts '**************Metodo expired extras******************'
        puts "Fecha de ejecucion: #{Time.now.strftime('%B %d del %Y %H:%M:%S')}"
        puts 'No hay resultados encontrados'
        puts '**************************************'
        system("exec sync && sysctl -w vm.drop_caches=3")
      end
    rescue Exception => e
        puts '**************ERROR Metodo expired extras******************'
        puts "Fecha de ejecucion: #{Time.now.strftime('%B %d del %Y %H:%M:%S')}"
        puts e.to_s
        puts '**************************************' 
    end
  }

  scope :for_win, ->(m, d){
    begin
      extras = Extra.where('updated_at <= ? AND active=? AND customer_id <> NULL', 
                                (Time.now - m.months) - d.days,  
                                Environment::STATUS[:repuestos][:activo])
      if extras.size > 0
         extras.each do |extra|
           Customer::CustomerMailer.for_win(extra).deliver
           puts '**************Metodo for_win extras******************'
           puts "Fecha de ejecucion: #{Time.now.strftime('%B %d del %Y %H:%M:%S')}"
           puts "El sistema deshabilitara el servicio #{extra.name} fecha de activacion #{extra.updated_at.strftime('%B %d del %Y')}"
           puts '************Fin del proceso***********************'   
         end
         system("exec sync && sysctl -w vm.drop_caches=3")
      else
        puts '**************Metodo for_win extras******************'
        puts "Fecha de ejecucion: #{Time.now.strftime('%B %d del %Y %H:%M:%S')}"
        puts 'No hay resultados encontrados'
        puts '**************************************'
        system("exec sync && sysctl -w vm.drop_caches=3")
      end
    rescue Exception => e
        puts '**************ERROR Metodo for_win extras******************'
        puts "Fecha de ejecucion: #{Time.now.strftime('%B %d del %Y %H:%M:%S')}"
        puts e.to_s
        puts '**************************************'
    end
  }

end
