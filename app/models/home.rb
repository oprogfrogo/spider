class Home < ActiveRecord::Base
  belongs_to :user
  has_one :quotes_home, dependent: :destroy

end
