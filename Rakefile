$:.unshift 'lib'
require "ottawa_transit_feed"
require "rake/testtask"

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = FileList["test/*/*_test.rb"]
  test.verbose = true
end

task :download do
  feed = "transit_feeds/oc_transpo"
  url  = "http://www.octranspo1.com/files/google_transit.zip"
  zip  = Date.today.strftime("transit_feeds/oc_transpo_%Y%m%d.zip")
  `mkdir -p #{feed}`
  `wget #{url} --output-document=#{zip}`
  `unzip #{zip} -d #{feed}` if Dir.glob("#{feed}/*").empty?
end

task :import do
  OttawaTransitFeed.import "transit_feeds/oc_transpo"
end

task :export do
  OttawaTransitFeed.export "transit_feeds/ottawa_transit_feed"
end

task :import_stop_times do
  OttawaTransitFeed::StopTime.import! "transit_feeds/oc_transpo"
end

task :import_trips do
  OttawaTransitFeed::Trip.import! "transit_feeds/oc_transpo"
end

namespace :db do
  task :create  do
    OttawaTransitFeed.create_database
  end

  task :reset  do
    OttawaTransitFeed.reset_database
  end
end