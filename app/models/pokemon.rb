class Pokemon < ActiveRecord::Base
  has_many :profiles
  belongs_to :type

end
