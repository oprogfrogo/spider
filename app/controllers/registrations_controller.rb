class RegistrationsController < ApplicationController

  def index
    render new_registration_path
  end

  def new
    @user = User.new()
  end

  def create
    @user = User.create(params[:user])

    if @user.valid?
      Notifications.new_user(@user, request.base_url).deliver_now
      flash.now[:success] = "Please check your email to confirm your email address."
    end

    respond_to do |format|
      format.html { render new_registration_path }
    end
  end

  def resend_confirmation_email
    @user = User.find(Rails.cache.read("uid-#{session.id}"))
    if @user.present?
      Notifications.new_user(@user, request).deliver_now
      flash[:success] = "Confirmation link resent. Please check your email."
      redirect_to sessions_path
      return
    else
      flash.now[:alert] = "Oops! Something went wrong. Please register again."
    end

    respond_to do |format|
      format.html { render new_registration_path }
    end
  end

  def confirm_email
    @user = User.where(token: params[:t]).try(:first)
    if @user.present?
      @user.confirmed = 'Y'
      @user.save
      flash[:success] = "Thank you for verifying your email address"
    else
      flash[:alert] = "Sorry we are having difficulties verifying your account"
    end

    respond_to do |format|
      format.html
    end
  end
end
