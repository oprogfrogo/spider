class QuotesAutoController < ApplicationController

  before_action :twilio, only: [:send_quote]
  before_action :check_agent_auth, only: [:index, :homes, :autos]

  def send_quote_auto
    @bronze = QuotesAuto.new(params[:bronze])
    @bronze.auto_id = params[:auto_id]
    @bronze.category = 'bronze'
    @bronze.agent_id = Agent.where(login: Rails.cache.read("agent-#{session.id}")).try(:first).try(:id)

    @silver = QuotesAuto.new(params[:silver])
    @silver.auto_id = params[:auto_id]
    @silver.category = 'silver'
    @silver.agent_id = Agent.where(login: Rails.cache.read("agent-#{session.id}")).try(:first).try(:id)

    @gold = QuotesAuto.new(params[:gold])
    @gold.auto_id = params[:auto_id]
    @gold.category = 'gold'
    @gold.agent_id = Agent.where(login: Rails.cache.read("agent-#{session.id}")).try(:first).try(:id)

    if @bronze.valid? && @silver.valid? && @gold.valid?
      @auto = Auto.find(params[:auto_id])
      @auto.status = 'quoted'
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
      redirect_to draw_quote_auto_path(id: params[:auto_id])
      return
    end

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

    agent = Agent.find_by_login(Rails.cache.read("agent-#{session.id}"))
    quotes = QuotesAuto.where(auto_id: params[:auto_id])

    Notifications.auto_quote_approve(@auto.user, @auto, agent, quotes).deliver_now

    respond_to do |format|
      format.html { redirect_to controller: 'agents', action: 'index' }
    end
  end

  def edit_multiple
    @quotes_auto = QuotesAuto.where(auto_id: 1)
    logger.error(@quotes_auto.count)
  end

  def update_multiple
    @quote = QuotesAuto.update(params[:quotes_autos].keys, params[:quotes_autos].values)
    @quote.reject! { |p| p.errors.empty? }
    if @quote.empty?
      flash[:success] = "Updated default values for Auto Quotes"
      redirect_to agents_url
    else
      flash[:alert] = "Problem updating Auto Quotes!"
      render "edit_multiple"
    end
  end

end
