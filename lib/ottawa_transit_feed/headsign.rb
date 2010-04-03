require "oc_transpo"

module OttawaTransitFeed
  class Headsign < Record
    extend HeadsignFunctions
    
    validates_presence_of :route_id, :stop_ids, :signature
    
    belongs_to :route, :foreign_key => :route_id, :primary_key => :route_id
    
    before_validation :set_signature
    
    serialize :stop_ids

    def set_signature
      self.signature = Headsign.signature_for route, stop_ids
    end
  end
end