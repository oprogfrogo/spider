class AgentsController < ApplicationController

  def index
    @agent = Agent.new
    session[:quote_token] = params[:quote_token] if params[:quote_token].present?

    if session[:agent].present?
      @home_quotes = Home.all
      @quotes = Quote.where(kind: 'home').collect(&:promo).uniq
    end
  end

  def login
    if params[:agent].present?
      agent = Agent.where(params[:agent]).try(:first)

      session[:agent] = agent.login if agent.present?
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
    end
  end

end
