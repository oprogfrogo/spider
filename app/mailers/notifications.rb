class Notifications < ApplicationMailer

  default from: 'Spider Policy <noreply@spiderpolicy.com>'

  def home_quote_request(user, homes)
    @user = user
    @homes = homes

    mail(to: 'oprogfrogo@gmail.com', subject: 'New Customer Home Quote Request')
  end

  def home_quote_approve(user, home, agent, quotes)
    @user = user
    @home = home
    @agent = agent
    @quotes = quotes

    mail(to: @user.email, subject: 'Home Quote Approval!')
  end

  def auto_quote_approve(user, auto, agent, quotes)
    @user = user
    @auto = auto
    @agent = agent
    @quotes = quotes

    mail(to: @user.email, subject: 'Auto Quote Approval!')
  end

  def new_user(user, request)
    @user = user
    @domain = Rails.env.development? ? "#{request.protocol}#{request.host}:#{request.port}" : "http://spiderpolicy.xyz"

    mail(to: @user.email, subject: 'Please confirm your email')
  end

  def contact_us(contact)
    @contact = contact

    mail(to: Global::DefaultCompanyEmail, subject: 'New Comment From spiderpolicy.com Website' )
  end

end
