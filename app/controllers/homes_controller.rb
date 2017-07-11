class HomesController < ApplicationController

  public
  def new
    @home = Home.new()
    @session = Session.new()
    logger.error("SESSION: #{Rails.cache.read("uid-#{session.id}")}")
  end

  def create
    begin
      @session = Session.new

      if Rails.cache.read("uid-#{session.id}").present?
        @user = User.where(id: Rails.cache.read("uid-#{session.id}")).try(:first)
        @home = Home.new(params[:home])
        @home.user_id = @user.id
        if @home.valid?
          @home.status = 'pending'
          @home.token = SecureRandom.uuid
          @home.save
          flash[:success] = "Thank you, we have received your quote request. An agent will contact you shortly regarding your new quote."
        end
      else
        @user = User.new(params[:user])
        @user.build_profile(params[:profile])
        if @user.valid?
          @user.save
          @home = Home.new(params[:home])
          @home.user_id = @user.present? ? @user.id : User.where(email: params[:user][:email]).try(:first).id
          if @home.valid?
            @home.status = 'pending'
            @home.save
            flash[:success] = "Thank you, we have received your quote request. An agent will contact you shortly regarding your new quote."
          end
        else
          @user = User.new(params[:user])
          @user.build_profile(params[:profile])
          @home = Home.new(params[:home])
          @user.valid?
          @home.valid?
          render action: 'new'
          return
        end
      end

      respond_to do |format|
        format.html { redirect_to controller: :welcome, action: :index}
      end

    rescue => e
      logger.error("EXC <homes_create>: #{e}, #{e.backtrace.join("\n")}")
      flash[:alert] = "Internal Error. For assistance, please contact admin@spiderpolicy.com"
      ErrorsMailer.notify_admin('oprogfrogo@gmail.com', "Error on homes create: #{e.backtrace.join("\n")}")
    end
  end

end
