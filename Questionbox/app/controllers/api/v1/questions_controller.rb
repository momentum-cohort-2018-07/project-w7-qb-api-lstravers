class Api::V1::QuestionsController < ApplicationController
  # before_action :verify_authentication
  # before_action :set_username,  only: [:index, :create, :show, :update, :destroy]
  before_action :set_question, only: [:show, :update, :destroy]
  
  helper_method :current_username

  def index
    @questions = Question.all
    render json: @questions
  end

  def new
    if current_username
      @question = Question.new
    else
      flash[:notice] = "You must be logged in to post a question"
      redirect_to new_api_v1_question_path
    end
  end
 
  def show
    render json: @question
  end

  def create
    vquestion=params["question"]
    if vquestion.length > 1 && vquestion.length < 281
    @question = Question.create(
        quesion: params["question"],
        username_id: @username.id
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
    if @current_username.id == @username.id
      @quesion.destroy 
    else 
      render json: { error: "Invalid Action" }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_username
    #   # @username = Username.find(params["username_id"])
    # end

    def set_question
      @question= Question.find(params["id"])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:question)
    end

end