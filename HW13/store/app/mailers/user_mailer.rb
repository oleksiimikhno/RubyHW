class UserMailer < ApplicationMailer
  def order(user, order)
    @user = user

    mail(to: @user.email, subject: "StoreName: Order #{order.id}")
  end

  def welcome_message(user)
    @user = user

    mail(to: @user.email, subject: 'New account information')
  end
end
