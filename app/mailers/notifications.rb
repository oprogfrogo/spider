class Notifications < ApplicationMailer

  default from: 'noreply@spiderpolicy.com'

  def home_quote_request(user, homes)
    @user = user
    @homes = homes

    mail(to: 'oprogfrogo@gmail.com', subject: 'A New Home Quote Request')
  end

  def home_quote_approve(user, home, agent, quotes)
    @user = user
    @home = home
    @agent = agent
    @quotes = quotes

    mail(to: @user.email, subject: 'Home Quote Approval!')
  end

end
