module OttawaTransitFeed
  module HeadsignFunctions

    def signature_for (route, stop_ids)
      Digest::MD5.hexdigest "OC Transpo Headsign #{route.number} #{stop_ids * '-'}"
    end

    def find_or_create! (route, stop_ids)
      if headsign = find_by_signature(signature_for(route, stop_ids))
        return headsign
      else
        create! :route => route, :stop_ids => stop_ids
      end
    end
    
    def import
      import_missing_headsigns
      import_missing_strings
    end

    def import_missing_headsigns
      for trip in Trip.all_missing_headsigns
        headsign = find_or_create!(trip.route, trip.stop_ids)
        trip.headsign = headsign
        trip.save!
      end
    end
    
    def export
      data = all.map do |headsign|
        headsign.attributes.except(:id)
      end
      File.open("lib/oc_transpo/headsigns.yml", 'w') { |f| f << YAML.dump(data) }
    end
    
    def import_missing_strings
      for headsign in all_missing_strings
        puts headsign.inspect
        headsign.set_string
        puts headsign.string
        headsign.save!
        puts ''
      end
      :finished
    end
    
    def cleanup
      goners = all.select { |headsign| headsign.trips.count.zero? }
      goners.each(&:destroy).size
    end
  end
end