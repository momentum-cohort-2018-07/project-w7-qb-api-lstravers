class AnswersController < ApplicationController

  def new
    @question = Question.find(params[:question_id])
        if current_user
            @answer = Answer.new
        else
            flash[:notice] ="You must be logged in to answer."
            redirect_to new_session_path
        end
  end
  
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      NotifierMailer.notify(@answer.user).deliver_now
       redirect_to question_path(@answer.question.id)
    else
      redirect_to question_path(@answer.question.id)
      flash[:comment] ="Answer can't be blank."
    end
  end

  def show
    @answer = Answer.find(params[:id])
  end

  private
    def answer_params
      params.require(:answer).permit(:question_id, :body, :user_id)
    end

end