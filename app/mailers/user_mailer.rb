class UserMailer < ApplicationMailer
  default from: 'test_shop@gmail.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome Mail')
  end
end
