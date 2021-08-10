class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email
  validates :email, email: true
  validates_presence_of :password_digest
  validates_uniqueness_of :email

  before_create :create_api_key

  def create_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end
