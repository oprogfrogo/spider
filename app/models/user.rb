class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :autos, dependent: :destroy
  has_many :homes, dependent: :destroy

  validates_confirmation_of :password
end
