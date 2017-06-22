class AgentsController < ApplicationController

  layout 'agents'

  before_action :check_agent_auth, only: [:homes, :autos]

  def draw_quote_auto
    @quotes_auto = QuotesAuto.new
    @bronze      = QuotesAuto.find(1)
    @silver      = QuotesAuto.find(2)
    @gold        = QuotesAuto.find(3)

    respond_to do |format|
      format.html
    end
  end

  def resend_quote_auto
    @auto = Auto.find(params[:id])

    flash[:success] = "Quote has been resent"
    redirect_to controller: 'agents', action: 'index'
  end

  def homes
    @agent = Agent.new
    Rails.cache.write("quote_token-#{session.id}", params[:quote_token]) if params[:quote_token].present?

    @home_quotes = Home.all
    @quotes = QuotesHome.all.collect(&:promo_date).uniq

    if @home_quotes.blank?
      flash[:alert] = "No results found for Homes"
      render action: 'index'
    end
  end

  def autos
    @agent = Agent.new
    Rails.cache.write("quote_token-#{session.id}", params[:quote_token]) if params[:quote_token].present?

    @auto_quotes = Auto.where.not(id: 1)

    if @auto_quotes.blank?
      flash[:alert] = "No results found for Autos"
      render action: 'index'
    end
  end

  def login
    if params[:agent].present?
      agent = Agent.where(params[:agent]).try(:first)

      Rails.cache.write("agent-#{session.id}", agent.login) if agent.present?
    end

    respond_to do |format|
      format.html
    end
  end

  def auth
    agent = Agent.where({ login: params[:login], password: params[:password] }).try(:first)
    if agent.present?
      Rails.cache.write("agent-#{session.id}", agent.login)
    else
      flash[:alert] = 'Invalid username or password'
      redirect_to action: 'login'
      return
    end

    respond_to do |format|
      format.html { redirect_to action: 'index'}
    end
  end

  def logout
    Rails.cache.delete("agent-#{session.id}")

    respond_to do |format|
      format.html { redirect_to action: 'login'}
    end
  end

end
