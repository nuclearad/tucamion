class House < ActiveRecord::Base



  has_attached_file :picture, :styles => {:home => '350x214>', :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/



end
