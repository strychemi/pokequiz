class Question < ActiveRecord::Base
  include AnswerStats

  belongs_to :category
  has_many :results

  validates :solution, :question, :category, :frequency, presence: true
  validates :question, uniqueness: :true

  def question_generator

  end
end
