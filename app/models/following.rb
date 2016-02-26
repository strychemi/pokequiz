class Following < ActiveRecord::Base

  after_create :add_activity

  belongs_to :followed, class_name: 'User', foreign_key: :followed_id
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id

  has_many :activities, as: :activable

  validates :follower, :followed, presence: true

  validates :follower_id, :uniqueness => { :scope => :followed_id, message: "You are already following this user."}

  def add_activity
    act = Activity.new(activable_type: 'Following', activable_id: self.followed_id)
    act.user_id = self.follower_id
    act.event = "#{User.find(self.follower_id).profile.full_name} followed #{User.find(self.followed_id).profile.full_name}"
    act.save
    logger.debug "Generated result activity: {#{act.event}}"
  end

end
