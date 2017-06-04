class AgentsController < ApplicationController

  layout 'agents'
  
  def index
    if session[:agent].present?
      @agent = Agent.new
      session[:quote_token] = params[:quote_token] if params[:quote_token].present?

      @home_quotes = Home.all
      @quotes = Quote.where(kind: 'home').collect(&:promo_date).uniq
    else
      redirect_to action: 'login'
    end
  end

  def login
    if params[:agent].present?
      agent = Agent.where(params[:agent]).try(:first)

      session[:agent] = agent.login if agent.present?
    end

    respond_to do |format|
      format.html
    end
  end

  def auth
    agent = Agent.where({ login: params[:login], password: params[:password] }).try(:first)
    if agent.present?
      session[:agent] = agent.login
    else
      flash[:alert] = 'Invalid username or password'
      redirect_to action: 'login'
    end

    respond_to do |format|
      format.html { redirect_to action: 'index'}
    end
  end

  def logout
    session[:agent] = nil

    respond_to do |format|
      format.html { redirect_to action: 'login'}
    end
  end

end
