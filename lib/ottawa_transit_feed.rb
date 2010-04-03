require "rubygems"
gem "activesupport", "= 2.3.5"
gem "activerecord",  "= 2.3.5"
gem "fastercsv"

require "active_support"
require "active_record"

ActiveSupport::Dependencies.load_paths << File.dirname(__FILE__)

module OttawaTransitFeed
  extend self
  
  Time.zone = "Eastern Time (US & Canada)"
  
  # Import a transit feed into the database.
  def import (feed)
    feeders.each do |records|
      report = records.import(feed)
      puts report if report && env == :development
    end
    Headsign.import
  end

  # Export a transit feed from the database.  
  def export (feed)
    `mkdir -p #{feed}`
    feeders.each do |records|
      records.export feed
    end
    # Headsign.export "headsigns.yml"
  end

  attr_writer :env

  def env
    @env || :development
  end

  def database
    "db/#{OttawaTransitFeed.env}.sqlite3"
  end
  
  def create_database
    Schema.create unless File.exist? database
  end

  def reset_database
    File.delete database if File.exist? database
    create_database
  end
  
  def clear_database
    record_classes.each do |records|
      records.delete_all
    end
  end

  protected
  
  def feeders
    [Agency, Calendar, CalendarDate, Route, Stop, StopTime, Trip]
  end

  def record_classes
    [Agency, Calendar, CalendarDate, Headsign, Route, Stop, StopTime, Trip]
  end

  def self.included (base)
    submodule_file_names = Dir.glob(__FILE__.sub(".rb", "/*")).map { |path| File.basename(path, ".rb") }
    submodule_file_names.each do |file_name|
      "OttawaTransitFeed::#{file_name.camelize}".constantize
    end
  end
end
