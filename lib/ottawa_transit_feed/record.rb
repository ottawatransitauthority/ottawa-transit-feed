module OttawaTransitFeed
  class Record < ActiveRecord::Base
    
    establish_connection :adapter => 'sqlite3', :database => "db/#{OttawaTransitFeed.env}.sqlite3", :timeout => 120000

    self.connection.execute("PRAGMA default_cache_size = 200000")
    self.connection.execute("PRAGMA default_synchronous = OFF")
    self.connection.execute("PRAGMA journal_mode = OFF")
    self.connection.execute("PRAGMA temp_store = MEMORY")


    self.abstract_class = true
    
    self.logger = Logger.new("log/#{OttawaTransitFeed.env}.log")

    def self.subclasses
      super
    end
  end
end
