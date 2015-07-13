namespace :db do
  desc "seed tags/bangbangs"
  task :create_tags_and_bangbangs => :environment do

    Tag.delete_all
    Tag.reset_pk_sequence
    Action.delete_all
    Action.reset_pk_sequence
    


    Tag.create!(title: "#LearnRails", :id => 1)
    Tag.create!(title: "#RailsTutorial", :id => 2)
    Tag.create!(title: "#FinishRailsBook", :id => 3)
    Tag.create!(title: "#Lose20Lbs", :id => 4)
    Tag.create!(title: "#LearnSpanish", :id => 5)
    Tag.create!(title: "#NikkoJacksonMMAFightJune15", :id => 6)
    Tag.create!(title: "#TakeSATs", :id => 7)

    Action.create!(title: "!!Did10Pushups", :id => 1)
    Action.create!(title: "!!Read50Pages", :id => 2)
    Action.create!(title: "!!ShowedUp", :id => 3)
    Action.create!(title: "!!WentToSCA", :id => 4)
    Action.create!(title: "!!WentToClass", :id => 5)
    Action.create!(title: "!!BoughtABike", :id => 6)
    Action.create!(title: "!!Rode20Miles", :id => 7)

  end
end