module OttawaTransitFeed
  class CalendarDate < Record
    
    # Calendar date records allow you to explicitly activate or disable calendar services by date. 
    #
    # The General Transit Specification defines two ways to use them:
    #   
    #   Recommended: 
    #   Use calendar_dates.txt in conjunction with calendar.txt, where calendar_dates.txt defines
    #   any exceptions to the default service categories defined in the calendar.txt file. If your 
    #   service is generally regular, with a few changes on explicit dates (for example, to 
    #   accomodate special event services, or a school schedule), this is a good approach.
    #   
    #   Alternate: 
    #   Omit calendar.txt, and include ALL dates of service in calendar_dates.txt. If your schedule
    #   varies most days of the month, or you want to programmatically output service dates without 
    #   specifying a normal weekly schedule, this approach may be preferable.
    #
    # Ottawa Transit Feed follows the recommended practice. 
    #
    # The calendar date dataset provided in the OC Transpo feed is usually accurate and complete. 
    # Ottawa Trasnsit Feed doesn’t apply any changes to this dataset.

    extend Feeder

    feed_attributes :service_id, :date, :exception_type
  
    validates_presence_of *feed_attributes
  end
end