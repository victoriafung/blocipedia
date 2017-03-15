include WikisHelper
class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :body, length: { minimum: 10 }, presence: true
  validates :user, presence: true

  def self.public?
    where(private: false)
  end
end
