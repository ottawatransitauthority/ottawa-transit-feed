require "digest/md5"

module OttawaTransitFeed
  module TripHacks

    def self.fix
      all(:conditions=>{:headsign => nil, :service_id => "NOV09-NOVDA09-Weekday-02"}).each do |trip|
        trip.save!
        next if trip.headsign.present?
        puts ""
        puts "----------------"
        puts trip.inspect
        puts trip.suggest_patch
      end
    end

    def detect_destination
      schedule = OCTranspo::MobileStopSchedule.find(:date => Date.parse(calendar.start_date), :route => route.number, :direction => route_heading, :location => stop_times.first.stop.code)
      if schedule
        departure = schedule[:departures].detect do |departure|
          departure[:time].strftime('%H:%M:%S') == stop_times.first.departure_time
        end
        departure[:destination] if departure
      end
    end
  
    def detect_destination
      schedule = OCTranspo::MobileRouteSchedule.find(:date => Date.parse(calendar.start_date), :route => route.number, :direction => route_heading, :location_index => detect_location_index_of_first_stop)
      if schedule
        departure = schedule[:departures].detect do |departure|
          departure[:time].strftime('%H:%M:%S') == stop_times.first.departure_time
        end
        departure[:destination] if departure
      end
    end
  
    def detect_destination
      stop_times.each do |stop_time|
        if location_index = detect_location_index_of(stop_time.stop)
          if destination = detect_destination_by_departure_time_and_location_index(stop_time.departure_time, location_index)
            return destination
          end
        end
      end
    end
  
    def detect_destination_by_departure_time_and_location_index (departure_time, location_index)
      schedule = OCTranspo::MobileRouteSchedule.find(:date => Date.parse(calendar.start_date), :route => route.number, :direction => route_heading, :location_index => location_index)
      puts schedule.inspect
      if schedule
        departure = schedule[:departures].detect do |departure|
          departure[:time].strftime('%H:%M:%S') == departure_time
        end
        departure[:destination] if departure
      end
    end
  
    def detect_location_index_of (stop)
      route_data     = OCTranspo::MobileRouteData.find(route.number, :date => Date.parse(calendar.start_date))
      direction_data = route_data.detect { |direction_data| direction_data[:direction] == route_heading }
      stop_data = direction_data[:stops].detect { |stop_data| stop_data[:number] == stop.code }
      direction_data[:stops].index(stop_data)
    end

    def detect_location_index_of_first_stop
      first_stop     = stops.first
      route_data     = OCTranspo::MobileRouteData.find(route.number, :date => Date.parse(calendar.start_date))
      direction_data = route_data.detect {|direction_data| direction_data[:direction] == route_heading }
      found = direction_data[:stops].detect do |stop_data|
        stop_data[:number] == first_stop.code
      end
      direction_data[:stops].index(found)
    end
  
    def detect_location_index_of_second_stop
      second_stop     = stops.second
      route_data     = OCTranspo::MobileRouteData.find(route.number, :date => Date.parse(calendar.start_date))
      direction_data = route_data.detect {|direction_data| direction_data[:direction] == route_heading }
      found = direction_data[:stops].detect do |stop_data|
        stop_data[:number] == second_stop.code
      end
      direction_data[:stops].index(found)
    end
  
    def suggest_patch
      destination = detect_destination
      if destination
        %(#{route.number} should be #{route.number} #{destination} when '#{stops.last.stop_id}' # #{stops.last.name})
      end
    end
  end
end
