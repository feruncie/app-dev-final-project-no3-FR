class UsersController < ApplicationController

  def index 
    @the_user = User.all
    render({ :template => "users/index"})
  end 

  def show 

    the_id = params.fetch("path_id")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show" })  
  end 

end 
