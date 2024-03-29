class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :hashtags
	validates :title, presence:true, length: {minimum: 5}
	validates :body, presence:true
	has_attached_file :image, styles: { medium: "300x300>" }
	validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
  acts_as_taggable	  	
  acts_as_likeable
  acts_as_mentioner
end
