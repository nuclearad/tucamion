class Truck < ActiveRecord::Base
  belongs_to :brand_truck
  belongs_to :type_truck
  belongs_to :sub_truck
  belongs_to :city
  belongs_to :state
  belongs_to :customer
  has_many :messages, -> { where(tipo: 1)}, :foreign_key => :item

  belongs_to :colors_truck
  belongs_to :spaces_truck
  belongs_to :boxes_truck
  belongs_to :contracts_truck
  belongs_to :scraps_truck
  belongs_to :wheels_truck
  belongs_to :motors_truck
  belongs_to :transmissions_truck


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
      :state_id => 'Departamento',
      :brand_truck_id => 'Marca',
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

  scope :like_join, ->(str){
    self.where("trucks.nombre LIKE '%#{str}%' OR
                brand_trucks.name LIKE '%#{str}%' OR
                type_trucks.name LIKE '%#{str}%' OR
                sub_trucks.name LIKE '%#{str}%'")#.group('trucks.id')
  }

end
