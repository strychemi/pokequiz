class UserMailer < ApplicationMailer

  def welcome_email(user)
    @greeting = "Hi"
    @user = user
    mail to: user.email, subject: 'Welcome to PokeQuiz!'
  end

end
