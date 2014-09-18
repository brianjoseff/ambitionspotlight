namespace :db do
  desc "add users and make them follow"
  task :following => :environment do
    require 'faker'
    require 'forgery'
    #users
    15.times do |n|
      name = Faker::Name.name
      email = Faker::Name.first_name + '@' + Forgery(:LoremIpsum).word(:random => true) + '.edu'
      password = Forgery(:basic).password + "123"
      occupation = Forgery(:LoremIpsum).paragraph(:random => true)
      bio = Forgery(:LoremIpsum).paragraph(:random => true)
      current_activities = Forgery(:LoremIpsum).paragraph(:random => true)
      ambition = Forgery(:LoremIpsum).paragraph(:random => true)
      # zip = Forgery(:address).zip
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   bio: bio,
                   occupation: occupation,
                   current_activities: current_activities,
                   ambition: ambition)
    end

    users = User.all
    users.each { |user|
      4.times do |x|
        user_id = Forgery(:Basic).number(:at_least => 1, :at_most => 15)
        f =Followship.new(:followed_id => user_id,
                           :follower_id => user.id)
        if Followship.where(:followed_id => user_id, :follower_id => user.id).blank?
          Followship.create(:followed_id => user_id,
                             :follower_id => user.id)
        end
      end
    }
  end
end