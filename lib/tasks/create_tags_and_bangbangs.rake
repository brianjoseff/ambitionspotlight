namespace :db do
  desc "seed tags/bangbangs"
  task :create_tags_and_bangbangs => :environment do

    Tag.delete_all
    Tag.reset_pk_sequence
    Bangbang.delete_all
    Bangbang.reset_pk_sequence
    


    Tag.create!(title: "#LearnRails", :id => 1)
    Tag.create!(title: "#RailsTutorial", :id => 2)
    Tag.create!(title: "#FinishRailsBook", :id => 3)
    Tag.create!(title: "#Lose20Lbs", :id => 4)
    Tag.create!(title: "#LearnSpanish", :id => 5)
    Tag.create!(title: "#NikkoJacksonMMAFightJune15", :id => 6)
    Tag.create!(title: "#TakeSATs", :id => 7)

    Bangbang.create!(title: "!!Did10Pushups", :id => 1)
    Bangbang.create!(title: "!!Read50Pages", :id => 2)
    Bangbang.create!(title: "!!ShowedUp", :id => 3)
    Bangbang.create!(title: "!!WentToSCA", :id => 4)
    Bangbang.create!(title: "!!WentToClass", :id => 5)
    Bangbang.create!(title: "!!BoughtABike", :id => 6)
    Bangbang.create!(title: "!!Rode20Miles", :id => 7)

  end
end