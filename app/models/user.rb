class User < ApplicationRecord
  
  has_many :articles, dependent: :destroy
  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, length: { in: 3..25 }

  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, length: { maximum: 105 }
  validate :validates_user_email

  before_save { self.email = email.downcase }

  private

  def validates_user_email
    unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors.add(:email, "is not an email")
    end
  end

end