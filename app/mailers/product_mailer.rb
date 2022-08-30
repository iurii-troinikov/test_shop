class ProductMailer < ApplicationMailer
  def price_is_changed
    @product = params[:product]
    @user = params[:user]

    mail(to: @user.email, subject: "Hey hey, let's see new price")
  end
end
