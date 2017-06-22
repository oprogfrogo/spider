class QuotesAutoController < ApplicationController

  before_action :twilio, only: [:send_quote]
  before_action :check_agent_auth, only: [:index, :homes, :autos]

  def send_quote_auto
    @bronze = QuotesAuto.new(params[:bronze])
    @bronze.category = 'bronze'

    @silver = QuotesAuto.new(params[:silver])
    @silver.category = 'silver'

    @gold   = QuotesAuto.new(params[:gold])
    @gold.category = 'gold'

    if @bronze.valid? && @silver.valid? && @gold.valid?
      @auto = Auto.find(params[:bronze]['auto_id'])
      @auto.status = 'completed'
      @auto.save
      @bronze.save
      @silver.save
      @gold.save
    else
      error_output = ""
      @bronze.errors.full_messages.each {|error|
        error_output += "#{error}<br/>"
      }

      flash[:alert] = error_output.html_safe
      redirect_to draw_quote_auto_path(id: params[:bronze]['auto_id'])
      return
    end

    # promo_dates_passed = true
    #
    # params['customer'].each{|x|
    #   x.delete_if { |key, value| value.blank? }
    #   next if x.blank?
    #   promo_dates_passed = false if x['promo_date'].blank?
    # }
    #
    # if promo_dates_passed
    #   quotes = params['customer'].reject { |c| c.empty? }
    #   autos = Auto.where(id: quotes.map{|x| x['id']})
    #
    #   autos.each {|auto|
    #     auto.promo_date = quotes.select{|s| s['id'] == auto.id.to_s}.first['promo_date']
    #     auto.save
    #   }
    #
    #   agent = Agent.find_by_login(Rails.cache.read("agent-#{session.id}"))
    #
    #   if agent.blank?
    #     flash[:alert] = "Please login as an agent before performing agent tasks"
    #     redirect_to controller: 'agents', action: 'login'
    #     return
    #   end
    #
    #   logger.info("#{autos.count} found. Sending SMS.")

      # autos.each {|auto|
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

    #     quotes = QuotesAuto.where(promo_date: params[:customer].select{|s| s['id'] == auto['id'].to_s}.first['promo_date'])
    #
    #     Notifications.auto_quote_approve(auto.user, auto, agent, quotes).deliver_now
    #   }
    # else
    #   flash[:alert] = "You must select a Promo for each quote"
    #   redirect_to controller: 'agents', action: 'index'
    #   return
    # end

    respond_to do |format|
      format.html { redirect_to controller: 'agents', action: 'index' }
    end
  end

end