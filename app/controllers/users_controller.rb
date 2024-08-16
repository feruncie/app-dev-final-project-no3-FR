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

  def edit_profile
    render({ :template => "users/edit_profile" })
  end 

  def update_profile
    @the_user = User.find_by({ :id => current_user.id })
    @the_user.first_name = params.fetch("first_name")
    @the_user.last_name = params.fetch("last_name")
    @the_user.biography = params.fetch("biography")
    @the_user.current_occupation = params.fetch("current_occupation")
    @the_user.goals = params.fetch("goals")
    @the_user.industry = params.fetch("industry")
    @the_user.interests = params.fetch("interests")
    @the_user.location = params.fetch("location")
    @the_user.linkedin_profile = params.fetch("linkedin_profile")
    @the_user.mentee = params.fetch("mentee")
    @the_user.mentor = params.fetch("mentor")

    if @the_user.save
      redirect_to("/users/#{@the_user.id}") # Redirect to a desired path after updating
    else
      render({ :template => "users/edit_profile" }) # Re-render the form if update fails
    end
  end

end 
