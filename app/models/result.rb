class Result < ActiveRecord::Base
  include AnswerStats

  belongs_to :user
  belongs_to :question

  has_many :activities, as: :activable

  validates :user, :question, presence: true
  validates :result, presence: true, inclusion: { in: [true, false] }

  def self.total_answers
    count
  end

  # TODO: Come back when we have seeds to test on
  
  def hardest_questions(n = 10)
    # Select questions where
    Result.select('question').group(:question).order('answer_ratio ASC').limit(n)
  end
  
  def easiest_questions(n = 10)

  end

  def hardest_categories(n = 2)

  end
  
  def easiest_categories(n = 2)

  end
end
