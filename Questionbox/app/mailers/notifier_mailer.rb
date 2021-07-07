class NotifierMailer < ApplicationMailer

  def notify(user)
    @user = user
    @greeting = "Your question has just received an answer."
   
    mail(  
      to: @user.email,
      from: 'Q&A.com',
      subject: 'Q&A - Your answer is here!'
      )
  end
end