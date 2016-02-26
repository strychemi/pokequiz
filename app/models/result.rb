class Result < ActiveRecord::Base
  include AnswerStats

  belongs_to :user
  belongs_to :question

  has_many :activities, as: :activable

  validates :user, :question, presence: true
  validates :result, presence: true, inclusion: { in: ['true', 'false'] }

  def self.total_answers
    count
  end

  # TODO: Come back when we have seeds to test on

  def self.hardest_questions(n = 10)
    # Select questions where
    Result.joins(:question).select(:question).where("result = true").group("question_id").count("*")
  end

  def self.easiest_questions(n = 10)
    Result.joins(:question).select(:question).where("result = false").group("question_id").count("*")
  end

  def self.hardest_categories(n = 2)
    []
  end

  def self.easiest_categories(n = 2)
    []
  end
end
