class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { minimum: 10 }

  before_save :truncate_body

  def truncate_body
    self.sample = "#{body.truncate(600)}..."
  end
end
