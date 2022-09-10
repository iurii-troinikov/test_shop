class UserMailer < ApplicationMailer
  default from: 'test_shop@gmail.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome Mail")
  end

  def order_created
    @email = params[:email]
    @name = params[:name]
    @total_amount = params[:total_amount]

    mail(to: @email, subject: "Order is ready")
  end
end
