class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank you for signing up on BugMe! 🐞')
  end
end
