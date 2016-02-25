class ResultsController < ApplicationController
  before_action :require_current_user

  def show
    @result = Result.find(params[:id])
  end

  def new
    @result = Result.new
    @question = Question.generate_answers(category) #Need this method to return an array of answers
  end

  def create
    @result = Result.new(result_params)
    if @result.save
      flash[:success] = "Answer submitted"
      result_path(@result)
    else
      flash[:error] = "There was a problem with your answer"
      redirect_to new_result_path
    end
  end

  private

  def result_params
    params.require(:result).permit(:user_id, :question_id, :result)
  end
end
