class QuotesController < ApplicationController

  before_action :twilio, only: [:send_quote]
  before_action :check_agent_auth, only: [:index, :homes, :autos]

  def index
    @auto_promos = QuotesAuto.all
    @auto_promos = @auto_promos.collect(&:promo_date).uniq

    @home_promos = QuotesHome.all
    @home_promos = @home_promos.collect(&:promo_date).uniq
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

  def edit_auto
    @quote_auto = QuotesAuto.find(params[:id])
  end

  def edit_home
    @quote_home = QuotesHome.find(params[:id])
  end

  def update_auto
    @quote = QuotesAuto.find(params[:id])
    @quote.attributes = params[:quote]
    if @quote.save
      flash[:success] = "Successfully updated"
    else
      flash[:alert] = "Update failed"
    end

    redirect_to edit_quote_path, id: params[:id]
  end

  def update_home
    @quote = QuotesHome.find(params[:id])
    @quote.attributes = params[:quote]
    if @quote.save
      flash[:success] = "Successfully updated"
    else
      flash[:alert] = "Update failed"
    end

    redirect_to edit_quote_path, id: params[:id]
  end

end
