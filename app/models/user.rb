class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages, dependent: :destroy
  has_many :trucks, dependent: :destroy
  has_many :extras, dependent: :destroy
  has_many :services, dependent: :destroy


  def list_messages
    self.messages.includes(:truck, :service, :extra).order("status DESC, tipo, created_at DESC")
  end


  def messages_no_leidos
    self.messages.where(:status => 1)
  end

end
