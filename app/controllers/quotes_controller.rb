class QuotesController < ApplicationController

  before_action :twilio, only: [:send_quote]

  def send_quote
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

        quotes = Quote.where(promo_date: '2017-06-01')

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

end
