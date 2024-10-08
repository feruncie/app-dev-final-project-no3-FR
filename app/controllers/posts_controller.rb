class PostsController < ApplicationController
  def index
    matching_posts = Post.all

    @list_of_posts = matching_posts.order({ :created_at => :desc })

    render({ :template => "posts/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_posts = Post.where({ :id => the_id })

    @the_post = matching_posts.at(0)

    render({ :template => "posts/show" })
  end


  before_action :authenticate_user!, { :only => [:create]}
  def create
    the_post = Post.new
    the_post.title = params.fetch("query_title")
    the_post.body = params.fetch("query_body")
    

    if the_post.valid?
      the_post.save
      redirect_to("/posts", { :notice => "Post created successfully." })
    else
      redirect_to("/posts", { :alert => the_post.errors.full_messages.to_sentence })
    end
  end

  before_action :authenticate_user! 
  before_action :ensure_correct_user, { :only => [:update] }

  def update
    the_id = params.fetch("path_id")
    the_post = Post.where({ :id => the_id }).at(0)

    the_post.title = params.fetch("query_title")
    the_post.body = params.fetch("query_body")

    if the_post.valid?
      the_post.save
      redirect_to("/posts/#{the_post.id}", { :notice => "Post updated successfully."} )
    else
      redirect_to("/posts/#{the_post.id}", { :alert => the_post.errors.full_messages.to_sentence })
    end
  end

  private 

  def ensure_correct_user
    the_id = params.fetch("path_id")
    the_post = Post.where({ :id => the_id }).at(0)

    if the_post.user_id != current_user.id 
      redirect_to("/posts", { :alert => "You cannot change another user's post"})
    end 
  end 

  def destroy
    the_id = params.fetch("path_id")
    the_post = Post.where({ :id => the_id }).at(0)

    the_post.destroy

    redirect_to("/posts", { :notice => "Post deleted successfully."} )
  end
end
