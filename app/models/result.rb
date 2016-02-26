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
    Result.find_by_sql("SELECT question_id,
                          COUNT(question_id) AS question_count
                          FROM results
                          JOIN questions
                            ON question_id = questions.id
                          WHERE result = 'false'
                          GROUP BY question_id
                          ORDER BY question_count DESC
                          LIMIT #{n}"
                      )
  end

  def self.easiest_questions(n = 10)
    Result.find_by_sql("SELECT question_id,
                          COUNT(question_id)
                          AS question_count
                          FROM results
                          JOIN questions
                            ON question_id = questions.id
                          WHERE result = 'true'
                          GROUP BY question_id
                          ORDER BY question_count DESC
                          LIMIT #{n}"
                      )
  end

  def self.hardest_category
    cat = Result.find_by_sql("SELECT category_id,
                          COUNT(question_id) AS question_count
                          FROM results
                          JOIN questions
                            ON question_id = questions.id
                          WHERE result = 'false'
                          GROUP BY category_id
                          ORDER BY question_count DESC
                          LIMIT 1"
                      )
    cat.map{ |r| [ Category.find(r.category_id), r.question_count ] }
  end

  def self.easiest_category
    cat = Result.find_by_sql("SELECT category_id,
                          COUNT(question_id) AS question_count
                          FROM results
                          JOIN questions
                            ON question_id = questions.id
                          WHERE result = 'true'
                          GROUP BY category_id
                          ORDER BY question_count DESC
                          LIMIT 1"
                      )
    cat.map{ |r| [ Category.find(r.category_id), r.question_count ] }
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
    logger.debug "Question #{q.question} asked"
  end


end
