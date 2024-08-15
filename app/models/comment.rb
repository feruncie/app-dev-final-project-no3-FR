# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
class Comment < ApplicationRecord

  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :post, required: true, class_name: "Post", foreign_key: "post_id"
  has_many  :comment_likes, class_name: "CommentLike", foreign_key: "comment_id", dependent: :destroy

  validates :body, presence: true
end
