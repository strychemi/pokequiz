class Question < ActiveRecord::Base
  belongs_to :category
  has_many :results

  validates :solution, :question, :category, :frequency, presence: true
  validates :question, uniqueness: :true

end
