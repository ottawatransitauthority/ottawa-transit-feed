module OttawaTransitFeed
  module HeadsignFunctions

    def signature_for (route, stop_ids)
      Digest::MD5.hexdigest "OC Transpo Headsign #{route.number} #{stop_ids * '-'}"
    end

    def import
      for trip in Trip.all_missing_headsigns
        headsign = find_or_create!(trip.route, trip.stop_ids)
        trip.headsign = headsign
        trip.save!
      end
    end

    def find_or_create! (route, stop_ids)
      if headsign = find_by_signature(signature_for(route, stop_ids))
        return headsign
      else
        create! :route => route, :stop_ids => stop_ids
      end
    end
  end
end