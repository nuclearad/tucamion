class Message < ActiveRecord::Base

  belongs_to :truck
  belongs_to :extra
  belongs_to :service
end
