# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Post < ApplicationRecord

  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :comments, class_name: "Comment", foreign_key: "post_id", dependent: :destroy
  has_many  :post_likes, class_name: "PostLike", foreign_key: "post_id", dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
