class Photo < ActiveRecord::Base
  has_many :profiles

  has_attached_file :photo, :styles => { :medium => "300x300", :large => "500x500", :thumb => "100x100" }, :s3_host_name => 's3-us-west-2.amazonaws.com'

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates_with AttachmentSizeValidator, attributes: :photo, less_than: 5.megabytes

  validates_attachment_presence :photo, presence: true

  def photo_from_url(url)
    self.photo = open(url)
  end
  
end
