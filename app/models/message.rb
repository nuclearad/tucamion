class Message < ActiveRecord::Base

  belongs_to :truck
  belongs_to :extra
  belongs_to :service
  belongs_to :user
  belongs_to :customer
  
end
