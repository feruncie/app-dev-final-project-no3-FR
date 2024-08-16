class CommentsController < ApplicationController
  def index
    matching_comments = Comment.all

    @list_of_comments = matching_comments.order({ :created_at => :desc })

    render({ :template => "comments/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_comments = Comment.where({ :id => the_id })

    @the_comment = matching_comments.at(0)

    render({ :template => "comments/show" })
  end

  #before_action :authenticate_user!, { :only => [:create]}
  def create
    the_comment = Comment.new
    the_comment.user_id = current_user.id
    the_comment.post_id = params.fetch("query_post_id")
    the_comment.body = params.fetch("query_body")

    if the_comment.valid?
      the_comment.save
      redirect_to("/posts/#{the_comment.post_id}", { :notice => "Comment created successfully." })
    else
      redirect_to("/posts/#{the_comment.post_id}", { :alert => the_comment.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_comment = Comment.where({ :id => the_id }).at(0)

    the_comment.user_id = params.fetch("query_user_id")
    the_comment.post_id = params.fetch("query_post_id")
    the_comment.body = params.fetch("query_body")

    if the_comment.valid?
      the_comment.save
      redirect_to("/comments/#{the_comment.id}", { :notice => "Comment updated successfully."} )
    else
      redirect_to("/comments/#{the_comment.id}", { :alert => the_comment.errors.full_messages.to_sentence })
    end
  end

  before_action :authenticate_user!
  before_action :ensure_correct_user, { :only => [:destroy]}
  def destroy
    the_id = params.fetch("path_id")
    the_comment = Comment.where({ :id => the_id }).at(0)
    post_id = the_comment.post_id

    the_comment.destroy

    redirect_to("/posts/#{post_id}", { :notice => "Comment deleted successfully."} )
  end

  private

  def ensure_correct_user
    the_id = params.fetch("path_id")
    the_comment = Comment.where({ :id => the_id }).at(0)

    if the_comment.user_id != current_user.id
      redirect_to("/posts#{post_id}", { :alert => "You are not authorized to delete this comment." })
    end
  end
end
