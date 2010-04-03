module OCTranspo
  module MobileRouteData

    include MobileResourceMethods
    extend self

    # Provides an interface for retreiving basic information about an OC Transpo transit route. Data is
    # sourced from http://octranspo.com/mobileweb/jnot/post.routelist.schedules.oci
    # 
    # = Usage
    # 
    # OCTranspo::MobileRouteData.find returns an array of direction hashes for a single route. Most routes 
    # operate in two directions so you will usually receive an array with two items in it. For example:
    #  
    #   # Find data for OCTranspo bus route 2 on today’s date
    #   route_data = OCTranspo::MobileRouteData.find(2)
    #   
    #   # Bus route 2 has two directions
    #   route_data.size  # => 2
    #   
    #   # 2 BAYSHORE is the first direction
    #   route_data[0][:route]            # => "2"
    #   route_data[0][:direction]        # => "BAYSHORE"
    #   route_data[0][:direction_index]  # => "2"
    #   route_data[0][:stops]            # => [{:name => "RIDEAU 4A", :number => "3009"}, ...]
    #   
    #   # 2 DOWNTOWN is the opposite direction
    #   route_data[1][:route]            # => "2"
    #   route_data[1][:direction]        # => "DOWNTOWN / CENTRE-VILLE"
    #   route_data[1][:direction_index]  # => "1"
    #   route_data[1][:stops]            # => [{:name => "BAYSHORE 4B", :number => "3050"}, ...]
    #
    # = Notes
    #
    # The direction_index attributes returned by OCTranspo::MobileRouteData methods are always the values 
    # "1" or "2". These values correspond to the direction_index argument in OCTranspo::MobileRouteSchedule. 
    # Sometimes the first direction has the value "1", sometimes it has the value "2". When a route only has
    # one direction it usually has the value "1". All in all very confusing.
      
    # Returns an array of direction hashes or nil if the route was not found. 
    def find (route_name_or_number, options={})
      options[:route] = route_name_or_number
      directions = find_all_directions(options)
      if directions.any?
        return directions
      end
    end
    
    def find_all_directions (options={})
      directions = []
      0.upto(1) do |index|
        directions << find_one_direction(options.merge(:index => index))
      end
      directions.compact
    end
    
    def find_one_direction (options={})
      decode(read(options))
    end
    
    def url_for (options={})
      options = default_options.merge(options)
      url = "#{site}/jnot/post.routelist.schedules.oci?"
      url << "rangeIndex=5&day=#{date_stamp(options[:date])}"
      url << "&route=#{options[:route]}&routeIndex=#{options[:index]}"
    end
    
    def path_for (options={})
      options = default_options.merge(options)
      "#{date_stamp(options[:date])}/route_#{options[:route]}_index_#{options[:index]}.html"
    end
    
    def decode (source_code)
      document = interpret(source_code)
      if table_of_stops = document.at("#SchedulesStopListStopsTable")
        direction = extract_route_and_direction_from(table_of_stops.search(:td)[1].inner_text)
        direction[:direction_index] = document.at("#direction")[:value].sub('Direction', '')
        direction[:stops] = table_of_stops.search("td.checkbox").map do |cell|
          extract_location_from(cell.inner_text.strip)
        end
        return direction
      end
    end
  end
end