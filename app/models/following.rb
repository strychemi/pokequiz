class Following < ActiveRecord::Base
  belongs_to :followed, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  has_many :activities, as: :activable

  validates :follower, :followed, presence: true

  validates :follower_id, :uniqueness => { :scope => :followed_id, message: "You are already following this user."}

end
