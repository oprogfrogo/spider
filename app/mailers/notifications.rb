class Notifications < ApplicationMailer

  default from: 'noreply@spiderpolicy.com'

  def home_quote_request(user, homes, agent)
    @user = user
    @homes = homes
    @agent = agent

    mail(to: @agent.email, subject: 'A New Home Quote Request')
  end

end
