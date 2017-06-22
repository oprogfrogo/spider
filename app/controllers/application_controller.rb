class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery# with: :exception

  before_action :verify_logged_in

  def verify_logged_in
    logger.info("Session ID: #{session.id}")
    if Rails.cache.read("uid-#{session.id}").present?
      user_email = User.where(id: Rails.cache.read("uid-#{session.id}")).try(:first).try(:email)
      @signed_in = "Welcome #{user_email}" if user_email.present?
    end
  end

  def check_agent_auth
    if Rails.cache.read("agent-#{session.id}").blank?
      flash[:alert] = "Please login first."
      redirect_to agent_login_url
    end
  end

  private
  def twilio
    account_sid = 'AC980887bc91baffc2087016570b99db44'
    auth_token = '4e2150f9496a72f176bb990130f713cb'
    @client = Twilio::REST::Client.new account_sid, auth_token
    Twilio.configure do |config|
      config.account_sid = account_sid
      config.auth_token = auth_token
    end
    @client = Twilio::REST::Client.new
  end
end
