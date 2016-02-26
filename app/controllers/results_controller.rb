class ResultsController < ApplicationController
  before_action :require_login
  before_action :current_user, only: [:index]

  def index
    @results = current_user.results.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @result = Result.find_by_id(params[:id])
    if @result.nil?
      flash[:danger] = "That result doesn't exist!"
      redirect_to users_path
    elsif @result.user_id != current_user.id
      flash[:danger] = "Not authorized to view this!"
      redirect_to users_path
    end
  end

  def new
    @result = Result.new
    @question = Question.all.sample # seeding questions
    # Implement as below for more question categories
    # case rand(1..Category.all.size)
    # when 1
    #   @question = Question.make_photo_question
    # when 2
    #   @question = Question.make_type_question
    # when 3
    #   @question = Question.make_effectiveness_question
    # end
    session[:question_id] = Base64.encode64(@question.id.to_s)
  end

  def create
    new_params = result_params
    @result = Result.new(user_id: current_user.id)

    @question = Question.find_by_id(Base64.decode64(session[:question_id]).to_i)
    if @question
      if @question.solution == new_params[:user_response]
        @result.result = "true"
      else
        @result.result = "false"
      end

      @result.question_id = @question.id
      if @result.save
        flash[:success] = "Answer submitted"
        redirect_to result_path(@result)
      else
        flash[:danger] = "There was a problem with your answer"
        redirect_to users_path
      end
    else
      flash[:danger] = "That question doesn't exist!"
      redirect_to users_path
    end
  end

  private

  def result_params
    params.require(:result).permit(:user_response, :question_id, :result)
  end
end
