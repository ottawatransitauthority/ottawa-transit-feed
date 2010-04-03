require "rubygems"
gem "activesupport", "= 2.3.5"
gem "activerecord",  "= 2.3.5"
gem "fastercsv"

require "active_support"
require "active_record"

module OttawaTransitFeed
  extend self
  
  Time.zone = "Eastern Time (US & Canada)"
  
  # Import a transit feed into the database.
  def import (feed)
    feeders.each do |records|
      report = records.import(feed)
      puts report if report && env == :development
    end
  end

  # Export a transit feed from the database.  
  def export (feed)
    `mkdir -p #{feed}`
    feeders.each do |records|
      records.export feed
    end
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
    load_modules
    [Agency, Calendar, CalendarDate, Route, Stop, StopTime, Trip]
  end

  def record_classes
    load_modules
    Record.subclasses
  end
  
  def append_features (base)
    load_modules
    super
  end

  def load_modules
    module_file_names.each do |file_name|
      "#{self.name}::#{file_name.camelize}".constantize
    end
  end

  def module_file_names
    Dir.glob(__FILE__.sub(".rb", "/*")).map { |path| File.basename(path, ".rb") }
  end

  module_file_names.each do |file_name|
    autoload file_name.camelize, "#{self.name.underscore}/#{file_name}"
  end
end
