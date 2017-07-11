class AutosController < ApplicationController

  def new
    @auto = Auto.new()
    @session = Session.new()
  end

  def create
    begin
      @session = Session.new

      if Rails.cache.read("uid-#{session.id}").present?
        @user = User.where(id: Rails.cache.read("uid-#{session.id}")).try(:first)
        @auto = Auto.new(params[:auto])
        @auto.user_id = @user.id
        if @auto.valid?
          @auto.status = 'pending'
          @auto.token = SecureRandom.uuid
          @auto.save
          flash[:success] = "Thank you, we have received your quote request. An agent will contact you shortly regarding your new quote."
        end
      else
        @user = User.new(params[:user])
        @user.build_profile(params[:profile])
        if @user.valid?
          @user.save
          @auto = Auto.new(params[:auto])
          @auto.user_id = @user.present? ? @user.id : User.where(email: params[:user][:email]).try(:first).id
          if @auto.valid?
            @auto.status = 'pending'
            @auto.token = SecureRandom.uuid
            @auto.save
            flash[:success] = "Thank you, we have received your quote request. An agent will contact you shortly regarding your new quote."
          end
        else
          @user = User.new(params[:user])
          @user.build_profile(params[:profile])
          @auto = Auto.new(params[:auto])
          @user.valid?
          @auto.valid?
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
