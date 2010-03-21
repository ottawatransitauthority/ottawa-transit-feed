module OttawaTransitFeed
  class Agency < Record

    extend Feeder

    feed_attributes :agency_id, :agency_url, :agency_name, :agency_timezone, :agency_phone, :agency_lang

    validates_presence_of :name, :url, :timezone
  
    validates_uniqueness_of :name

    before_save :set_agency_id
    before_save :set_lang
    before_save :set_phone

    def self.feed_file
      "agency.txt"
    end
  
    protected
  
    def set_agency_id
      if agency_id.blank?
        self.agency_id = name
      end
    end

    def set_lang
      if lang.blank?
        self.lang = case name
          when "OC Transpo": "EN"
        end
      end
    end
  
    def set_phone
      if phone.blank?
        self.phone = case name
          when "OC Transpo": "613-560-1000"
        end
      end
    end
  end
end