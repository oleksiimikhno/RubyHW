class UserMailer < ApplicationMailer
  def welcome_message(user)
    @user = user

    mail(to: @user.email, subject: 'New account information')
  end
end
