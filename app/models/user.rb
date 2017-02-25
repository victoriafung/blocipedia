class User < ActiveRecord::Base
  enum role: [:admin, :standard, :premium]

  has_many :wikis
  before_save { self.email = email.downcase if email.present? }
  before_create :set_confirmation_token
  before_save { self.role ||= :standard }
  attr_accessor :reset_token
  # before_create :default_standard

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

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  def downgrade
    self.update_attribute(:role, 'standard')
  end

  private
  def default_standard
    self.role = 'standard'
  end

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end

end
