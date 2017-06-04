class HomesController < ApplicationController

  public
  def index
    @home = Home.new()
  end

  def create
    begin
      @user = User.new(params[:user])
      @user.dob = Date.new(params[:user]['dob(1i)'].to_i ,params[:user]['dob(2i)'].to_i, params[:user]['dob(3i)'].to_i)
      @user.save if @user.valid?

      @home = Home.new(params[:home])
      @home.user_id = @user.present? ? @user.id : User.where(email: params[:user][:email]).try(:first).id
      if @home.valid?
        @home.status = 'pending'
        @home.token = SecureRandom.uuid
        @home.save
      end

      flash[:success] = "Thank you, we have received your quote request. An agent will contact you shortly regarding your new quote."

      @user = User.where(email: params[:user][:email]).try(:first)
      @homes = @user.homes

      # Notifications.home_quote_request(@user, @homes).deliver_now

      respond_to do |format|
        format.html { redirect_to controller: :welcome, action: :index}
      end

    rescue => e
      logger.error("EXC <homes_create>: #{e}, #{e.backtrace.join("\n")}")
      flash[:alert] = "Internal Error. For assistance, please contact admin@spiderpolicy.com"
      ErrorsMailer.notify_admin('oprogfrogo@gmail.com', "Error on homes create: #{e.backtrace.join("\n")}")
    end
  end

  def approve_home_request

  end

end
