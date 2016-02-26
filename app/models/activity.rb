class Activity < ActiveRecord::Base
  belongs_to :user

  belongs_to :activable, polymorphic: :true

  validates :user, presence: true
  validates :event, presence: true
  validates :activable, presence: true
  validates :user_id, uniqueness: { scope: [:activable_id, :activable_type], message: "Event already logged in database!" }

  def self.followed_user_ids(current_user)
    if current_user.followeds.count > 0
      User.all.pluck(:id).select{|user_id| current_user.followeds.pluck(:id).include?(user_id)}
    else
      [0]
    end
  end

  def self.followed_activity_list(current_user)
    where("activities.user_id IN (#{Activity.followed_user_ids(current_user).join(', ')})").order("created_at DESC").limit(10)
  end
end
