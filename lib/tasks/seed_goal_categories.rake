namespace :db do
  desc "seed goal categories"
  task :seed_goal_categories => :environment do

    GoalCategory.delete_all
    GoalCategory.reset_pk_sequence

    


    GoalCategory.create!(:name => "Arts", :id => 1)
    GoalCategory.create!(:name => "Athletics", :id => 2)
    GoalCategory.create!(:name => "Business", :id => 3)
    GoalCategory.create!(:name => "Coding", :id => 4)
    GoalCategory.create!(:name => "Education", :id => 5)
    GoalCategory.create!(:name => "Music", :id => 6)
    GoalCategory.create!(:name => "Other", :id => 7)
  end
end