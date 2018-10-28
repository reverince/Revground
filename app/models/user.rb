class User < ApplicationRecord
  attr_accessor :remember_token, :reset_token
  has_many :microposts, dependent: :destroy

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :name,  presence: true, uniqueness: true,
                    length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 4 }
  before_save { self.email.downcase! }

  # Generate hash digest of string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Generate random base64 string
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    # token for cookie, digest for attribute
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Check if token matches digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

end
