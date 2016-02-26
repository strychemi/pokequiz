class SearchesController < ApplicationController
  before_action :require_login
  
  def index
    @search = User.search(params[:query]).top_scorers
  end

  def create
    if User.search(query_params)
      redirect_to searches_path(query_params)
    end
  end

  private

  def query_params
    params.permit(:query)
  end
end
