class QuotesController < ApplicationController

  before_action :twilio, only: [:send_quote]
  before_action :check_agent_auth, only: [:index, :homes, :autos]

  def index
    @auto_promos = QuotesAuto.all
    @home_promos = QuotesHome.all
  end

  def auto
    @quotes = QuotesAuto.where(promo_date: params[:d])

    respond_to do |format|
      format.html
    end
  end

  def home
    @quotes = QuotesHome.where(promo_date: params[:d])

    respond_to do |format|
      format.html
    end
  end

end
