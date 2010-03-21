module OttawaTransitFeed
  class Record < ActiveRecord::Base
    
    establish_connection :adapter => 'sqlite3', :database => "db/#{OttawaTransitFeed.env}.sqlite3", :timeout => 120000
    
    self.abstract_class = true
    
    self.logger = Logger.new("log/#{OttawaTransitFeed.env}.log")

    def self.subclasses
      super
    end
  end
end