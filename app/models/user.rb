class User < ApplicationRecord
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
end
