class Result < ActiveRecord::Base
  include AnswerStats

  after_create :add_activity
  after_create :increase_question_frequency

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
    Result.joins(:question).select(:question).where("result = 'true'").group("question_id").count("*")
  end

  def self.easiest_questions(n = 10)
    Result.joins(:question).select(:question).where("result = 'false'").group("question_id").count("*")
  end

  def self.hardest_categories(n = 2)
    []
  end

  def self.easiest_categories(n = 2)
    []
  end

  def add_activity
    act = Activity.new(activable_type: 'Result', activable_id: self.id)
    act.user_id = self.user_id
    act.event = self.result
    act.save
    logger.debug "Generated result activity: {#{act.event}} Answer Received"
  end

  def increase_question_frequency
    q = Question.find_by_id(self.question_id)
    q.frequency += 1
    q.save
  end
end
