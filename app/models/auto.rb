class Auto < ActiveRecord::Base
  belongs_to :user
  has_many :quotes_autos, dependent: :destroy
  
end
