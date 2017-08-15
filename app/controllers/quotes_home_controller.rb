class QuotesHomeController < ApplicationController

  before_action :twilio, only: [:send_quote]
  before_action :check_agent_auth, only: [:index, :homes, :autos]

  def send_quote_home
    begin
      @quotes_home = QuotesHome.new(params[:send_home])
      @quotes_home.home_id = params[:home_id]
      @quotes_home.agent_id = Agent.where(login: Rails.cache.read("agent-#{session.id}")).try(:first).try(:id)

      if @quotes_home.valid?
        @home = Home.find(params[:home_id])
        @home.status = 'quoted'
        @home.save

        @quotes_home.save
      else
        error_output = ""
        @quotes_home.errors.full_messages.each {|error|
          error_output += "#{error}<br/>"
        }

        flash[:alert] = error_output.html_safe
        redirect_to draw_quote_home_path(id: params[:home_id])
        return
      end

      # homes.each {|home|
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

      agent = Agent.find_by_login(Rails.cache.read("agent-#{session.id}"))
      quotes = QuotesHome.where(home_id: params[:home_id]).try(:first)

      Notifications.home_quote_approve(@home.user, @home, agent, quotes).deliver_now
    rescue => e
      logger.error("Exception: #{e} / #{e.backtrace.join("\n")}")
      flash[:alert] = "Unable to send a quote. Contact administrator"
    end
    respond_to do |format|
      flash[:success] = "Quote sent successfully to #{@home.user.email}"
      format.html { redirect_to controller: 'agents', action: 'index' }
    end
  end

  def edit
    @quotes_home = QuotesHome.find(1)
  end

  def update
    @quote = QuotesHome.find(1)
    @quote.attributes = params[:quotes_home]
    if @quote.save
      flash[:success] = "Successfully updated"
    else
      flash[:alert] = "Update failed"
    end

    redirect_to edit_quotes_home_path(1)
  end

end
