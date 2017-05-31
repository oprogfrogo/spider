class UsersController < ApplicationController

  def create
    params.permit!
    @user = User.new(params[:user])
    @user.save
    redirect_to quotes_path
  end

end
