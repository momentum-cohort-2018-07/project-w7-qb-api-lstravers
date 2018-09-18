class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end
 
  def new
    if current_username
      @question = Question.new
    else
      flash[:notice] ="You must be logged to post a new question."
      redirect_to new_session_path
    end
  end

  def create
    @question = Question.new(question_params)
   
    if @question.save
       redirect_to @question
    else
        render 'new'
    end
  end  
  

  def destroy 
    @quesiton = Question.find(params[:id])
    if current_user.id == @question.user_id
      @question.destroy
      redirect_to questions_path
    else
      flash[:notice] = 'Only question creator can delete.'
      redirect_to @question
    end
  end
 
  private
  #need to add user_id
    def question_params
       params.require(:question).permit(:body)
    end

end
