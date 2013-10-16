include BCrypt

class User < ActiveRecord::Base
  validates :password, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true

  has_many :posts
  has_many :comments
  has_many :postvotes
  has_many :commentvotes

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    return user if user && (user.password == password)
    nil
  end
end
