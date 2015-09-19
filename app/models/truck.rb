class Truck < ActiveRecord::Base
  belongs_to :brand_truck
  belongs_to :type_truck
  belongs_to :sub_truck
  belongs_to :city
  belongs_to :state
  belongs_to :customer
  has_many :messages, -> { where(tipo: 1)}, :foreign_key => :item, dependent: :destroy
  belongs_to :colors_truck
  belongs_to :spaces_truck
  belongs_to :boxes_truck
  belongs_to :contracts_truck
  belongs_to :scraps_truck
  belongs_to :wheels_truck
  belongs_to :motors_truck
  belongs_to :transmissions_truck
  belongs_to :referencia
  accepts_nested_attributes_for :customer
  validates_uniqueness_of :nombre, message: ' %{value} ya se encuentra registrado'
  validates_presence_of [:nombre, :price,:modelo, :placa, :brand_truck,:state,:city,
                         :placa_state_id,:placa_city_id, :kilometraje,:state_id,:brand_truck_id,
                         :colors_truck_id,:city_id,:tipocombustible,:estado,:pesobruto,:scraps_truck_id], message: 'No puede estar en blanco'
  has_attached_file :picture1, :styles =>  {:home => '900x900>', :medium => "600x600>", :thumb => '204x244'}, :default_url => "/images/missing.png",
                    :processor => "mini_magick",
                    :convert_options => {
                        :thumb => "-background white -compose Copy -gravity center -extent 204x244",
                        :medium => "-background white -compose Copy -gravity center -extent 600x600",
                        :home => "-background white -compose Copy -gravity center -extent 900x900"
                    }
  validates_attachment_content_type :picture1, :content_type => /\Aimage\/.*\Z/, :less_than => 1.megabytes




  has_attached_file :picture2, :styles =>  {:home => '900x900>', :medium => "600x600>", :thumb => '204x244'}, :default_url => "/images/missing.png",
                    :processor => "mini_magick",
                    :convert_options => {
                        :thumb => "-background white -compose Copy -gravity center -extent 204x244",
                        :medium => "-background white -compose Copy -gravity center -extent 600x600",
                        :home => "-background white -compose Copy -gravity center -extent 900x900"
                    }
  validates_attachment_content_type :picture2, :content_type => /\Aimage\/.*\Z/, :less_than => 1.megabytes


  has_attached_file :picture3, :styles =>  {:home => '900x900>', :medium => "600x600>", :thumb => '204x244'}, :default_url => "/images/missing.png",
                    :processor => "mini_magick",
                    :convert_options => {
                        :thumb => "-background white -compose Copy -gravity center -extent 204x244",
                        :medium => "-background white -compose Copy -gravity center -extent 600x600",
                        :home => "-background white -compose Copy -gravity center -extent 900x900"
                    }
  validates_attachment_content_type :picture3, :content_type => /\Aimage\/.*\Z/, :less_than => 1.megabytes


  has_attached_file :picture4, :styles =>  {:home => '900x900>', :medium => "600x600>", :thumb => '204x244'}, :default_url => "/images/missing.png",
                    :processor => "mini_magick",
                    :convert_options => {
                        :thumb => "-background white -compose Copy -gravity center -extent 204x244",
                        :medium => "-background white -compose Copy -gravity center -extent 600x600",
                        :home => "-background white -compose Copy -gravity center -extent 900x900"
                    }
  validates_attachment_content_type :picture4, :content_type => /\Aimage\/.*\Z/, :less_than => 1.megabytes


  has_attached_file :picture5, :styles =>  {:home => '900x900>', :medium => "600x600>", :thumb => '204x244'}, :default_url => "/images/missing.png",
                    :processor => "mini_magick",
                    :convert_options => {
                        :thumb => "-background white -compose Copy -gravity center -extent 204x244",
                        :medium => "-background white -compose Copy -gravity center -extent 600x600",
                        :home => "-background white -compose Copy -gravity center -extent 900x900"
                    }
  validates_attachment_content_type :picture5, :content_type => /\Aimage\/.*\Z/, :less_than => 1.megabytes









=begin
  validates :nombre, presence: true
  validates :modelo, presence: true
  validates :brand_truck_id, presence: true
  validates :type_truck_id, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true

  validates :kilometraje, presence: true
  validates :estado, presence: true
  validates :placa, presence: true
  validates :tipocombustible, presence: true
  validates :colors_truck_id, presence: true
  validates :placa_city_id, presence: true

  validates :placa_state_id, presence: true
  validates :contracts_truck_id, presence: true
=end



  HUMANIZED_ATTRIBUTES = {
      :nombre => 'Nombre',
      :city_id => 'Ciudad',
      :city => 'Ciudad',
      :state_id => 'Departamento',
      :brand_truck_id => 'Marca',
      :brand_truck => 'Marca',
      :state => 'Departamento',
      :type_truck_id => 'Tipo',
      :tipocombustible => 'Tipo combustible',
      :placa_city_id => 'Ciudad Matricula',
      :placa_state_id => 'Departamento Matricula'

  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end



  before_create do

    self.link_rewrite = self.nombre.downcase
    self.link_rewrite = I18n.transliterate(self.link_rewrite)

    if self.nombre.count(' ') >= 1
      self.link_rewrite = self.link_rewrite.gsub! ' ', '-'
    end

  end


  before_update do

    self.link_rewrite = self.nombre
    self.link_rewrite = I18n.transliterate(self.link_rewrite)

    if self.nombre.count(' ') >= 1
      self.link_rewrite = self.link_rewrite.gsub! ' ', '-'
    end

  end

  before_create :add_quantity_current

  def add_quantity_current
    quantity = Quantity.find_by(customer_id: self.customer_id)
    if quantity
      quantity.current_trucks += 1
      quantity.save
    end
  end


  scope :like_join, ->(str){
    self.joins("LEFT JOIN brand_trucks ON brand_trucks.id = trucks.brand_truck_id
                LEFT JOIN type_trucks  ON type_trucks.id =  trucks.type_truck_id
                LEFT JOIN sub_trucks ON sub_trucks.id = trucks.sub_truck_id").
         where("trucks.nombre LIKE '%#{str}%' OR
                brand_trucks.name LIKE '%#{str}%' OR
                type_trucks.name LIKE '%#{str}%' OR
                sub_trucks.name LIKE '%#{str}%' AND
                trucks.active = 1").uniq
  }


  scope :state_group, ->{
       self.select('trucks.id, trucks.nombre, trucks.state_id,
                    count(trucks.state_id) as total,
                    states.name as state_name').
            joins(:state).group('states.name').
            order('states.name DESC')

  }

   scope :marcas_group , ->{
       self.select('trucks.id, trucks.nombre, trucks.brand_truck_id,
                    count(trucks.brand_truck_id) as total,
                    brand_trucks.name as brand_name').
            joins(:brand_truck).group('brand_trucks.name').
            order('brand_trucks.name DESC')

  }

  scope :modelo_group , ->{
       self.select('trucks.id, trucks.modelo,
                    count(trucks.modelo) as total').
            group('trucks.modelo').
            order('trucks.modelo DESC')

  }


  scope :km_group , ->{
       self.select('trucks.id, trucks.kilometraje,
                    count(trucks.kilometraje) as total').
            group('trucks.kilometraje').
            order('trucks.kilometraje DESC')

  }

end
