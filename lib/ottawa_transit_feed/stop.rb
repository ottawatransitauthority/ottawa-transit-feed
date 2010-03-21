require "oc_transpo"

module OttawaTransitFeed
  class Stop < Record

    extend Feeder

    feed_attributes :stop_id, :stop_code, :stop_name, :stop_lat, :stop_lon
  
    before_save :set_code
  
    def name= (name)
      super OCTranspo::Lingo.translate_location(name)
      self.original_name = name
    end
  
    def stop_id= (stop_id)
      super stop_id
      self.code = find_code
    end

    protected
  
    def set_code
      if code.blank?
        self.code = find_code
      end
    end
  
    def find_code
      if data = OCTranspo::Stop::find_by_stop_id(stop_id)
        data[:code]
      end
    end
  end
end