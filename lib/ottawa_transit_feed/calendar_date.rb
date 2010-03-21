module OttawaTransitFeed
  class CalendarDate < Record

    extend Feeder

    feed_attributes :service_id, :date, :exception_type
  
    validates_presence_of *feed_attributes
  end
end