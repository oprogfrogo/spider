class UsersController < ApplicationController

  def users_check_exist
    @user = User.where({email: params[:email]})

    respond_to do |format|
      format.js { render json: @user.to_json }
    end
  end

  def index
    @user = User.new()
  end

  def create
    @user = User.where({email: params[:email], password: params[:password]})

    if @user.present?
      Rails.cache.write('uid', @user.id)
    end

    respond_to do |format|
      format.html { redirect_to action: 'homes' }
    end
  end

end
