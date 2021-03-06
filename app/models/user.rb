class User < ActiveRecord::Base
  before_save { self.email = email.downcase if email.present? }
  before_create :set_confirmation_token
  attr_accessor :reset_token

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 5, maximum: 254 }

has_secure_password


  def set_confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def create_reset_digest
    update_attribute(:reset_digest, User.digest(reset_token))
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  private
    def validate_email
      self.email_confirmed = true
      self.confirm_token = nil
    end

end
