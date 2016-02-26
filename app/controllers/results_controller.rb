class ResultsController < ApplicationController
  #before_action :require_current_user


  def show
    @result = Result.find(params[:id])
  end

  def new
    case rand(1..Category.all.size)
    when 1
      @question = Question.make_photo_question 
    when 2
      @question = Question.make_type_question
    when 3
      @question = Question.make_effectiveness_question
    end

    session[:question_id] = @question[4]
    #Need this method to return an array of answers
  end

  def create
    @new_params = result_params
    @result = Result.new(user_id: current_user.id)
    
    @question = Question.find_by_id(session[:question_id])

    if @question.solution == @new_params[:user_response]
      @result.result = "true"
    else
      @result.result = "false"
    end

    @result.question_id = @question.id
    if @result.save
      flash[:success] = "Answer submitted"
      redirect_to result_path(@result)
    else
      flash[:error] = "There was a problem with your answer"
      redirect_to new_result_path
    end
  end

  private

  def result_params
    params.require(:result).permit( :user_response, :question_id, :result)
  end
end
