# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :email, :session_token, presence: true, uniqueness:true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  
  attr_reader :password
  after_initialize :ensure_session_token
  
  has_many :subs,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :Sub
  has_many :posts, 
    foreign_key: :author_id, 
    class_name: :Post 
  
  def password=(pw)
    @pasword = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
  
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
  
  def self.generate_session_token 
    SecureRandom.urlsafe_base64
  end 
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end 
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end 
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
  end
  
end
