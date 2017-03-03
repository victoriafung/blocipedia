include WikisHelper
class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :body, length: { minimum: 10 }, presence: true
  validates :user, presence: true

  def self.public?
    where(private: false)
  end

  def markdown_title
    markdown_html(self.title)
  end

  def markdown_body
    markdown_html(self.body)
  end

end
