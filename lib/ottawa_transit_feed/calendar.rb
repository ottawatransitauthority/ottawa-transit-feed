module OttawaTransitFeed
  class Calendar < Record

    extend Feeder

    feed_attributes :service_id, :start_date, :end_date, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday
  
    validates_presence_of :service_id, :start_date, :end_date

    def self.feed_file
      "calendar.txt"
    end
  end
end