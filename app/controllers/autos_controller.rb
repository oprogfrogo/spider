class AutosController < ApplicationController
  
  public
  def index
    @auto = Auto.new
  end
  
end
