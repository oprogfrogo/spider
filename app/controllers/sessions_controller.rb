class SessionsController < ApplicationController

  def index
    @session = Session.new()
    @user = User.new()
  end

  def create
    @user = User.where({email: params[:email], password: params[:password]}).try(:first)
    Rails.cache.write("uid-#{session.id}", @user.id) if @user.present?

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
