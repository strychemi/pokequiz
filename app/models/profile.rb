class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile
  belongs_to :photo, foreign_key: :avatar_id
  belongs_to :pokemon
  belongs_to :pokemon_type

  validates :first_name, :last_name, :username, presence: true

  accepts_nested_attributes_for :photo,
                                :reject_if => :all_blank

  def full_name
    "#{first_name} #{last_name}"
  end
end
