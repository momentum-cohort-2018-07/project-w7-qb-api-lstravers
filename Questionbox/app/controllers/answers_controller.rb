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
      redirect_to question_path(@answer.quesiton.id)
    else
      redirect_to question_path(@answer.question.id)
      flash[:comment] ="Answer can't be blank."
    end
  end

  def show
    @answer = Answer.find(params[:id])
  end


  # def validate
  #   @quesiton = answer.find(params[:id])  
  #   respond_to :js, :html
  #   if current_user   
  #     if !current_user.liked? @answer
  #       @answer.liked_by current_user
  #       redirect_to @answer
  #     elsif current_user.liked? @answer
  #       @answer.unliked_by current_user
  #       redirect_to @answer
  #      end
  #   else
  #     flash[:notice] = 'Only users can validate, Please login'
  #     redirect_to @answer
  #   end
  # end

  private
    #need to add user_id
    def answer_params
      params.require(:answer).permit(:question_id, :body)
    end

end
