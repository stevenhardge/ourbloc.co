class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
      
  acts_as_likeable
  acts_as_mentioner
end
