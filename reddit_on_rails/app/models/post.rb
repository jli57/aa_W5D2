# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :bigint(8)        not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  
  validates :title, presence: true 
  validate :valid_content
  
  belongs_to :original_sub,
    foreign_key: :sub_id,
    class_name: :Sub
  
  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs

  belongs_to :author, 
    foreign_key: :author_id, 
    class_name: :User
    
  has_many :comments 
  
  def valid_content
    if (self.url == "" && self.content == "" ) || ( self.url != "" && self.content != "")
      self.errors[:url] << "Invalid content"
    end
  end
  
end
