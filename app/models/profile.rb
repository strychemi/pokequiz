class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo, foreign_key: :avatar_id
  belongs_to :pokemon

  validates :first_name, :last_name, :username, :user, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
