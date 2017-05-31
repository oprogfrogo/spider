class User < ActiveRecord::Base
  has_many :autos
  has_many :homes

  validates_presence_of :name, :phone_number, :email, :dob, :dl_number, :martial_status
end
