require "fastercsv"

module OttawaTransitFeed::Feeder

  # Feeders import and export transit feed CSV files.

  def self.extended (base)
    prefix = base.name.demodulize.underscore
    base.columns.each do |column|
      unless column.name.starts_with?(prefix) || column.primary
        base.alias_attribute "#{prefix}_#{column.name}", column.name
      end
    end
  end
  
  def import! (feed)
    delete_all and import(feed)
  end

  def import (feed)
    elapsed = Benchmark.realtime do
      self.transaction do      	
	FasterCSV.foreach "#{feed}/#{feed_file}", :headers => :first_row do |row|
       	 hash = row.to_hash
       	 hash.values.each { |value| value.strip! if value }
       	 record = new(hash)
       	 record.save!
      	end
     end #end transaction
    end
    "#{name}.import completed in #{elapsed}"
  end
  
  def export (feed)
    options = { :headers => feed_attributes, :write_headers => true }
    FasterCSV.open "#{feed}/#{feed_file}", "w", options do |csv|
      find_each do |model|
        csv << feed_attributes.map {|attribute| model.send(attribute) }
      end
    end
  end
  
  def feed_attributes (*attributes)
    @feed_attributes ||= []
    @feed_attributes.concat(attributes)
    return @feed_attributes
  end
  
  def feed_file
    "#{table_name}.txt"
  end
end
