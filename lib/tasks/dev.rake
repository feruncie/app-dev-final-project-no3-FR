desc "Fill the database tables with some sample data"
task({ :sample_users => :environment }) do
  20.times do 
    x = User.new

    x.first_name = Faker::Name.first_name
    x.last_name = Faker::Name.last_name
    x.username = Faker::Internet.username
    x.linkedin_profile = Faker::Internet.url(host: 'linkedin.com')
    x.mentor = [true, false].sample
    x.mentee = [true, false].sample
    x.biography = Faker::Lorem.paragraph
    x.industry = Faker::Company.industry
    x.interests = Faker::Hobby.activity
    x.location = Faker::Address.city
    x.current_occupation = Faker::Job.title
    x.goals = Faker::Lorem.sentence
    x.email = Faker::Internet.email
    x.password = Faker::Internet.password

    x.save
  end
end

  task(:sample_posts => :environment) do 

  user_ids = User.pluck(:id)
  
  20.times do 
    y = Post.new

    y.title = Faker::Lorem.sentence
    y.body = Faker::Lorem.paragraph
    y.user_id = user_ids.sample

    y.save
  end 
end 

task(:sample_comments => :environment) do 

  post_ids = Post.pluck(:id)
  user_ids = User.pluck(:id)
  
  20.times do 
    y = Comment.new

    y.body = Faker::Lorem.paragraph
    y.post_id = post_ids.sample
    y.user_id = user_ids.sample

    y.save
  end 
end 
