class Api::QuestionsController < ApplicationController
  before_action :verify_authenticity_token
  before_action :set_user,  only: [:index, :create, :show, :update, :destroy]
  before_action :set_question, only: [:show, :update, :destroy]
  
  helper_method :current_user

  def index
    @questions = Question.all
    render json: @questions
  end

  def new
    if current_user
      @question = Question.new
    else
      flash[:notice] = "You must be logged in to post a question"
      redirect_to api_questions_path
    end
  end
 
  def show
    render json: @question
  end

  def create
    vquestion=params["question"]
    if vquestion.length > 1 && vquestion.length < 281
    @question = Question.create(
        question: params["question"],
        user_id: @user.id
        )
      render json: @question
    else
      render json: { error: "Invalid question" }, status: :unauthorized
    end
  end

  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: { error: "Invalid Update" }, status: :unauthorized
    end
  end
  
  def destroy
    if @current_user.id == @user.id
      @question.destroy 
    else 
      render json: { error: "Invalid Action" }, status: :unauthorized
    end
  end

  private
  #Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params["user_id"])
    end

    def set_question
      @question= Question.find(params["id"])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:question)
    end
end
