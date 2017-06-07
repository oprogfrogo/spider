class SessionsController < ApplicationController

  def index
    @session = Session.new()
  end

  def create
    @user = User.where({email: params[:email], password: params[:password]}).try(:first)
    Rails.cache.write('uid', @user.id) if @user.present?

    respond_to do |format|
      format.html { redirect_to new_home_url }
    end
  end

  def logout
    Rails.cache.delete('uid')

    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

end
