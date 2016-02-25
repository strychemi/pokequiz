class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  has_many :activities, as: :activable

  validates :user, :question, presence: true
  validates :result, presence: true, inclusion: { in: [true, false] }


end
