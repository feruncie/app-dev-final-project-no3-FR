class UsersController < ApplicationController

  def index 
    @users = User.all
    render({ :template => "users/index"})
  end 

  def show 
    @users = User.all
    render({ :template => "users/show"})
  end 

end 
