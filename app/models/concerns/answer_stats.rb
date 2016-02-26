module AnswerStats
  extend ActiveSupport::Concern

  def questions_answered
    results.count
  end

  def correct_answers
    results.where("result = 'true'").count
  end

  def incorrect_answers
    results.where("result = 'false'").count
  end

  def answer_ratio
    correct_answers.to_f / questions_answered.to_f
  end
end
