class UsersController < ApplicationController

  def users_check_exist
    @user = User.where({email: params[:email]})

    respond_to do |format|
      format.js { render json: @user.to_json }
    end
  end

end
