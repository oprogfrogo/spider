class SessionsController < ApplicationController

  def index
    @session = Session.new()
    @user = User.new()
  end

  def create
    @user = User.where({email: params[:email], password: params[:password]}).try(:first)

    if @user.present?
      Rails.cache.write("uid-#{session.id}", @user.id)
      if @user.confirmed == 'N'
        flash[:success] = "Please verify your email address first. We sent you an email with a link. <a href='#{resend_confirmation_email_url}' class='button'>Resend Link</a>".html_safe
        redirect_to sessions_path
        return
      else
        flash[:success] = "Welcome back! Start your insurance quote."
      end
    else
      flash[:alert] = "Could not find an account with that email or password"
      redirect_to sessions_path
      return
    end

    respond_to do |format|
      format.html { redirect_to new_home_url }
    end
  end

  def logout
    Rails.cache.delete("uid-#{session.id}")

    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

end
