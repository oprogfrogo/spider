class WelcomeController < ApplicationController

  before_action :twilio, only: :home_insurance_quote

  public
  def store_zip
    Rails.cache.write('postal_code', params[:postal_code])
    respond_to do |format|
      format.html { redirect_to :new_home }
    end
  end

  def home_insurance
    @user = User.new
  end

  def home_insurance_quote
    # @client.messages.create(
      # from: '+14243583122',
      # to: '+13109515044',
      # body: 'Hey there!',
      # media_url: 'https://images.asia.finance/contents/images/20161107124431/insuranceagentWP.jpg'
    # )

    @user = User.new(params[:user])
    @user.save if @user.valid


    flash[:notice] = "Thank you"

    redirect_to action: :index
  end

  private
  def user_params
    params.require(:user).permit(:full_name, :phone, :email, :street, :street2, :city, :state, :zip)
  end

end
