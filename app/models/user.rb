class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :autos, dependent: :destroy
  has_many :homes, dependent: :destroy

  validates :password,
  :confirmation => true,
  :length => { :minimum => 6},
  :if => lambda{ new_record? || !password.nil? }

  validates_uniqueness_of :email, message: "already taken. Please log in or enter a different email."

  before_save :generate_uuid

  def generate_uuid
    self.token = SecureRandom.uuid
  end

end
