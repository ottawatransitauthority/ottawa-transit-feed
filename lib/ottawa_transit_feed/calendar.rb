module OttawaTransitFeed
  class Calendar < Record

    # Calendar records contain a service_id that uniquely identifies a set of dates when transit 
    # service is available for one or more routes. 
    #
    # The service_id value is dataset unique. It is referenced by trips and calendar dates.
    # 
    # The calendar dataset provided in the OC Transpo feed is usually accurate and complete. 
    # Ottawa Trasnsit Feed doesn’t apply any changes to this dataset.

    extend Feeder

    feed_attributes :service_id, :start_date, :end_date, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday
  
    validates_presence_of :service_id, :start_date, :end_date

    def self.feed_file
      "calendar.txt"
    end
  end
end