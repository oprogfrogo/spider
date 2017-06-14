class QuotesController < ApplicationController

  before_action :twilio, only: [:send_quote]
  before_action :check_agent_auth, only: [:index, :homes, :autos]

  def index
    @auto_promos = QuotesAuto.all
    @auto_promos = @auto_promos.collect(&:promo_date).uniq

    @home_promos = QuotesHome.all
    @home_promos = @home_promos.collect(&:promo_date).uniq
  end

  def auto
    @quotes = QuotesAuto.where(promo_date: params[:d])

    respond_to do |format|
      format.html
    end
  end

  def home
    @quotes = QuotesHome.where(promo_date: params[:d])

    respond_to do |format|
      format.html
    end
  end

  def edit_auto
    @quote_auto = QuotesAuto.find(params[:id])
  end

  def edit_home
    @quote_home = QuotesHome.find(params[:id])
  end

  def update_auto
    @quote = QuotesAuto.find(params[:id])
    @quote.attributes = params[:quote]
    if @quote.save
      flash[:success] = "Successfully updated"
    else
      flash[:alert] = "Update failed"
    end

    redirect_to edit_quote_path, id: params[:id]
  end

  def update_home
    @quote = QuotesHome.find(params[:id])
    @quote.attributes = params[:quote]
    if @quote.save
      flash[:success] = "Successfully updated"
    else
      flash[:alert] = "Update failed"
    end

    redirect_to edit_quote_path, id: params[:id]
  end

  def send_quote_home
    promo_dates_passed = true

    params['customer'].each{|x|
      x.delete_if { |key, value| value.blank? }
      next if x.blank?
      promo_dates_passed = false if x['promo_date'].blank?
    }

    if promo_dates_passed
      quotes = params['customer'].reject { |c| c.empty? }
      homes = Home.where(id: quotes.map{|x| x['id']})

      homes.each {|home|
        home.promo_date = quotes.select{|s| s['id'] == home.id.to_s}.first['promo_date']
        home.save
      }

      agent = Agent.find_by_login(Rails.cache.read("agent-#{session.id}"))

      if agent.blank?
        flash[:alert] = "Please login as an agent before performing agent tasks"
        redirect_to controller: 'agents', action: 'login'
        return
      end

      logger.info("#{homes.count} found. Sending SMS.")

      homes.each {|home|
        # @client.messages.create(
        #   from: '+18582640421',
        #   to: home.user.phone_number,
        #   body: "
        #     Hello,
        #
        #     Your home insurance quote has been sent to your email address at #{home.user.email}
        #
        #     I am here to assist you with any questions you might have about your quotes. Call me at 888-888-8888 if you have any questions.
        #   ",
        #   media_url: 'https://images.asia.finance/contents/images/20161107124431/insuranceagentWP.jpg'
        # )

        quotes = QuotesHome.where(promo_date: params[:customer].select{|s| s['id'] == home['id'].to_s}.first['promo_date'])

        Notifications.home_quote_approve(home.user, home, agent, quotes).deliver_now
      }
    else
      flash[:alert] = "You must select a Promo for each quote"
      redirect_to controller: 'agents', action: 'index'
      return
    end

    respond_to do |format|
      format.html { redirect_to controller: 'agents', action: 'index' }
    end
  end

  def send_quote_auto
    promo_dates_passed = true

    params['customer'].each{|x|
      x.delete_if { |key, value| value.blank? }
      next if x.blank?
      promo_dates_passed = false if x['promo_date'].blank?
    }

    if promo_dates_passed
      quotes = params['customer'].reject { |c| c.empty? }
      autos = Auto.where(id: quotes.map{|x| x['id']})

      autos.each {|auto|
        auto.promo_date = quotes.select{|s| s['id'] == auto.id.to_s}.first['promo_date']
        auto.save
      }

      agent = Agent.find_by_login(Rails.cache.read("agent-#{session.id}"))

      if agent.blank?
        flash[:alert] = "Please login as an agent before performing agent tasks"
        redirect_to controller: 'agents', action: 'login'
        return
      end

      logger.info("#{autos.count} found. Sending SMS.")

      autos.each {|auto|
        # @client.messages.create(
        #   from: '+18582640421',
        #   to: home.user.phone_number,
        #   body: "
        #     Hello,
        #
        #     Your home insurance quote has been sent to your email address at #{home.user.email}
        #
        #     I am here to assist you with any questions you might have about your quotes. Call me at 888-888-8888 if you have any questions.
        #   ",
        #   media_url: 'https://images.asia.finance/contents/images/20161107124431/insuranceagentWP.jpg'
        # )

        quotes = QuotesAuto.where(promo_date: params[:customer].select{|s| s['id'] == auto['id'].to_s}.first['promo_date'])

        Notifications.auto_quote_approve(auto.user, auto, agent, quotes).deliver_now
      }
    else
      flash[:alert] = "You must select a Promo for each quote"
      redirect_to controller: 'agents', action: 'index'
      return
    end

    respond_to do |format|
      format.html { redirect_to controller: 'agents', action: 'index' }
    end
  end

end
