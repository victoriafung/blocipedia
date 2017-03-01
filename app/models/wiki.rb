class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :body, length: { minimum: 10 }, presence: true
  validates :user, presence: true

  def self.public?
    where(private: false)
  end
end
