class Api::AnswersController < ApplicationController

  before_action :verify_authenticity_token
  before_action :set_question,  only: [:index, :create, :show, :update, :destroy]
  before_action :set_answer, only: [:show, :update, :destroy]
  
  def index
    @answers = @question.answers
    render json: @question.answers
  end

  def show
    render json: @answers
  end

  def new
    if current_user
      @answer = Answer.new
      @question = Question.find(params[:question_id])
    else
      flash[:notice] = "You must be logged in to post an answer."
    end
  end
  
  def create
    @answer = Answer.create(
        commenter: params["commenter"],
        body: params["body"],
        questions_id: @questions_id
        )
      render json: @answer
  end

  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params["question_id"])
    end

    def set_answer
      @answer= Answer.find(params["id"])
    end

    # Only allow a trusted parameter "white list" through.
    def answer_params
      params.require(:answer).permit(:commenter, :body)
    end
end