module OCTranspo
  module MobileRouteSchedule

    include MobileResourceMethods
    extend self

    # Provides an interface for retreiving OC Transpo timetables for a specific route, direction and location_index.
    # This API is somewhat less convenient than OCTranpo::MobileStopSchedule. 
    #
    # The data returned by this module is sourced from:
    # http://www.octranspo.com/mobileweb/jnot/post.stoplist.schedules.oci
    #
    # == Usage
    #   
    #   # Find the schedule for the 85 going to HURDMAN from Bayshore Station (the first stop on the route)
    #   schedule = OCTranspo::MobileRouteSchedule.find(:route => 85, :direction => "HURDMAN", :location_index => 0)
    #   schedule[:route]             # => "85"
    #   schedule[:direction]         # => "HURDMAN"
    #   schedule[:location][:name]   # => "BAYSHORE 4B"
    #   schedule[:location][:number] # => "3050"
    #   schedule[:date]              # => Date.current
    #   schedule[:departures]        # => [{:time => Time.zone.parse('04:12'), :destination => "HURDMAN"}, ...]
    #
    #   # Find the schedule for the 85 going to HURDMAN from Bronson Ave. & Somerset St. (53rd stop on the route)
    #   schedule = OCTranspo::MobileRouteSchedule.find(:route => 85, :direction => "HURDMAN", :location_index => 53)
    #   schedule[:route]             # => "85"
    #   schedule[:direction]         # => "HURDMAN"
    #   schedule[:location][:name]   # => "BRONSON / SOMERSET W-O"
    #   schedule[:location][:number] # => "6625"
    #   schedule[:date]              # => Date.current
    #   schedule[:departures]        # => [{:time => Time.zone.parse('04:42'), :destination => "HURDMAN"}, ...]

    # Return a Hpricot DOM representing source_code.
    def interpret (source_code)
      Hpricot(convert_to_utf_8(source_code))
    end
    
    def find (options={})
      options[:date] = if options[:date]
        options[:date].to_date          
      else
        Date.current
      end
      decode(read(options), options[:date])        
    end
    
    def find_one (options={})
      options[:date] = if options[:date]
        options[:date].to_date          
      else
        Date.current
      end
      decode(read(options), options[:date])
    end
    
    def decode (source_code, date)
      document = interpret(source_code)

      route_and_direction_text = document.at("#SchedulesTimesSelectedTable").search(:tr)[2].search(:td)[1].inner_text
      location_text            = document.at("#SchedulesTimesListTable td.header").inner_text
      departure_texts          = Array(document.search('#SchedulesTimesListTable td'))[1..-1].map do |cell| cell.inner_text.strip end
      
      schedule = {:date => date, :legend => {}}
      schedule.merge! extract_route_and_direction_from(route_and_direction_text)
      schedule[:destinations] = Hash.new(schedule[:direction])
      
      Array(document.search("#SchedulesTimesNotesTable td.notes")).in_groups_of(2) do |flag_cell, value_cell|
        flag = flag_cell.inner_text.sub('[', '').sub(']', '').strip
        text = value_cell.inner_text.strip
        if text.include?("Destination")
          schedule[:destinations][flag] = text.sub("Destination ", "")
        else
          schedule[:legend][flag] = text
        end
      end
      
      schedule[:location] = extract_location_from(location_text)
      schedule[:departures] = departure_texts.inject([]) do |departures, text|
        departures << extract_departure_from(text, schedule)
      end
      
      schedule[:headsigns] = schedule[:departures].map do |d| d[:destination] end.uniq
      
      return schedule
    end
    
    def default_options
      {:direction_index => 1, :location_index => 0, :date => Date.current}
    end
    
    def url_for (options={})
      options = default_options.merge(convert_options(options))
      url = "#{site}/jnot/post.stoplist.schedules.oci?"
      url << "rangeIndex=5&day=#{date_stamp(options[:date])}"
      url << "&route=#{options[:route]}"
      url << "&direction=Direction#{options[:direction_index]}"
      url << "&check#{options[:location_index]}=on"
    end
    
    def path_for (options={})
      options = default_options.merge(convert_options(options))
      "#{date_stamp(options[:date])}/route_#{options[:route]}_direction_#{options[:direction_index]}_location_#{options[:location_index]}.html"
    end
    
    def convert_options (options={})
      if options[:direction]
        route_data = MobileRouteData.find(options[:route], :date => options[:date])
        direction_data = route_data.detect do |dataset|
          dataset[:direction] === options[:direction]
        end
        if direction_data
          options[:direction_index] = direction_data[:direction_index]
        end
      end
      return options
    end
  end
end