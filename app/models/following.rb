class Following < ActiveRecord::Base
  belongs_to :followed, class_name: 'User', foreign_key: :followed_id
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id

  has_many :activities, as: :activable

  validates :follower, :followed, presence: true

  validates :follower_id, :uniqueness => { :scope => :followed_id, message: "You are already following this user."}

end
