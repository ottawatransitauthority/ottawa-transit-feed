$:.unshift 'lib'
require "ottawa_transit_feed"
require "rake/testtask"

task :default => [:setup, :test]

task :setup do 
  system "mkdir -p log"
  system "mkdir -p db"
  system "mkdir -p transit_feeds"
  OttawaTransitFeed.create_database
end

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = FileList["test/*/*_test.rb"]
  test.verbose = true
end

task :download => :setup do
  feed = "transit_feeds/oc_transpo"
  url  = "http://www.octranspo1.com/files/google_transit.zip"
  zip  = Date.today.strftime("transit_feeds/oc_transpo_%Y%m%d.zip")
  `mkdir -p #{feed}`
  `wget #{url} --output-document=#{zip}`
  puts `unzip #{zip} -d #{feed}` if Dir.glob("#{feed}/*").empty?
end

task :update => :setup do
  OttawaTransitFeed.update
end

task :import => :setup do
  OttawaTransitFeed.import "transit_feeds/oc_transpo"
end

task :import_stop_times => :setup do
  puts OttawaTransitFeed::StopTime.import!("transit_feeds/oc_transpo")
end

task :import_trips => :setup do
  puts OttawaTransitFeed::Trip.import!("transit_feeds/oc_transpo")
end

task :export => :setup do
  OttawaTransitFeed.export "transit_feeds/ottawa_transit_feed"
end

namespace :db do
  task :clear do
    OttawaTransitFeed.clear_database
  end
  
  task :create do
    OttawaTransitFeed.create_database
  end
  
  task :reset do
    OttawaTransitFeed.reset_database
  end
end

task :release => :setup do
  Dir.chdir "transit_feeds" do
    feed    = "ottawa_transit_feed"
    release = Date.today.strftime("ottawa_transit_feed_%Y%m%d")
    zip     = Date.today.strftime("ottawa_transit_feed_%Y%m%d.zip")
    `rm -rf #{release}`
    `cp -R #{feed} #{release}`
    puts `zip -vr #{zip} #{release}`
  end
end