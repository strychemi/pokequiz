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
    return 0 if questions_answered.to_f == 0
    correct_answers.to_f / questions_answered.to_f
  end
end
