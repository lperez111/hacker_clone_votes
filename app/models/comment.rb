class Comment < ActiveRecord::Base
  validates :content, presence: true
  
  belongs_to :user
  belongs_to :post
  has_many :commentvotes
end
