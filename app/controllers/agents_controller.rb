class AgentsController < ApplicationController

  layout 'agents'

  before_action :check_agent_auth, only: [:index, :homes, :autos]
  
  def index
    @agent = Agent.where(login: Rails.cache.read("agent-#{session.id}")).try(:first)
    agent_id = @agent.id
    @auto_ratings = QuotesAuto.where(agent_id: agent_id).select(:auto_id, :rating).where.not(id: 1, rating: nil).distinct(:auto_id)
    auto_sum = @auto_ratings.collect(&:rating).sum
    @auto_ratings_percent = (auto_sum == 0) ? 0 : (@auto_ratings.collect(&:rating).sum).to_f / (@auto_ratings.count * 5).to_f * 100
    @home_ratings = QuotesHome.where(agent_id: agent_id).select(:home_id, :rating).where.not(id: 1, rating: nil).distinct(:home_id)
    home_sum = @home_ratings.collect(&:rating).sum
    @home_ratings_percent = (home_sum == 0) ? 0 : (@home_ratings.collect(&:rating).sum).to_f / (@home_ratings.count * 5).to_f * 100
  end

  def draw_quote_auto
    @quotes_auto = QuotesAuto.new
    @bronze      = QuotesAuto.find(1)
    @silver      = QuotesAuto.find(2)
    @gold        = QuotesAuto.find(3)

    respond_to do |format|
      format.html
    end
  end

  def draw_quote_home
    @quotes_home_default = QuotesHome.find(1)

    respond_to do |format|
      format.html
    end
  end

  def resend_quote_auto
    @auto = Auto.find(params[:id])
    agent = Agent.find_by_login(Rails.cache.read("agent-#{session.id}"))
    quotes = QuotesAuto.where(auto_id: @auto.id)

    Notifications.auto_quote_approve(@auto.user, @auto, agent, quotes).deliver_now

    flash[:success] = "Quote has been resent"
    redirect_to controller: 'agents', action: 'index'
  end

  def resend_quote_home
    @home = Home.find(params[:id])
    agent = Agent.find_by_login(Rails.cache.read("agent-#{session.id}"))
    quotes = QuotesHome.where(home_id: @home.id).try(:first)

    Notifications.home_quote_approve(@home.user, @home, agent, quotes).deliver_now

    flash[:success] = "Quote has been resent"
    redirect_to controller: 'agents', action: 'index'
  end

  def homes
    @agent = Agent.new
    Rails.cache.write("quote_token-#{session.id}", params[:quote_token]) if params[:quote_token].present?

    @home_quotes = Home.where.not(id: 1)

    if @home_quotes.blank?
      flash[:alert] = "No results found for Homes"
      redirect_to action: 'index'
    end
  end

  def autos
    @agent = Agent.new
    Rails.cache.write("quote_token-#{session.id}", params[:quote_token]) if params[:quote_token].present?

    @auto_quotes = Auto.where.not(id: 1)

    if @auto_quotes.blank?
      flash[:alert] = "No results found for Autos"
      redirect_to action: 'index'
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
  
  def agent_manage
    @agents = Agent.all
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @agent = Agent.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def agent_edit
    @agent = Agent.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    agent = Agent.find(params[:id])
    agent.update_attributes(params[:agent])
    
    flash[:success] = "Successfully upated #{agent.name}'s record"
    redirect_to agent_manage_path
  end
  
  def create
    agent = Agent.new(params[:agent])
    agent.save
    
    flash[:success] = "Successfully upated #{agent.name}'s record"
    redirect_to agent_manage_path
  end
  
  def destroy
    agent = Agent.destroy(params[:id])
    
    flash[:success] = "Successfully upated #{agent.name}'s record"
    redirect_to agent_manage_path
  end

end
