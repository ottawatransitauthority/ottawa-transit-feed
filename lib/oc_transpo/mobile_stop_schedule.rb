module OCTranspo
  module MobileStopSchedule

    include MobileResourceMethods
    extend self

    # Provides an interface for retreiving OCTranspo timetables for a specific route and location. This API
    # is more convenient than OCTranpo::MobileStopSchedule but it doesn’t work for stops without numbers.
    #
    # The data returned by this module is sourced from:
    # http:/octranspo.com/mobileweb/jnot/post.routelist.stoptimes.oci
    # 
    # == Usage
    # 
    #   # Find the schedule for the 85 going to HURDMAN at Bayshore Station (the first stop on the route)
    #   schedule = OCTranspo::MobileStopSchedule.find(:route => 85, :direction => "HURDMAN", :location => "3050")
    #   schedule[:route]             # => "85"
    #   schedule[:direction]         # => "HURDMAN"
    #   schedule[:location][:name]   # => "BAYSHORE 4B"
    #   schedule[:location][:number] # => "3050"
    #   schedule[:date]              # => Date.current
    #   schedule[:departures]        # => [{:time => Time.zone.parse('04:12'), :destination => "HURDMAN"}, ...]
    #
    #   # Find the schedule for the 85 going to HURDMAN at Bronson Ave. & Somerset St.
    #   schedule = OCTranspo::MobileStopSchedule.find(:route => 85, :direction => "HURDMAN", :location => "6625")
    #   schedule[:route]             # => "85"
    #   schedule[:direction]         # => "HURDMAN"
    #   schedule[:location][:name]   # => "BRONSON / SOMERSET W-O"
    #   schedule[:location][:number] # => "6625"
    #   schedule[:date]              # => Date.current
    #   schedule[:departures]        # => [{:time => Time.zone.parse('04:42'), :destination => "HURDMAN"}, ...]
    
    def find (options={})
      route     = "#{options.delete(:route)}"
      direction = "#{options.delete(:direction)}"
      find_all(options).detect do |schedule|
        (schedule[:route] == route) && (schedule[:direction] == direction)
      end
    end
    
    def find_all (options={})
      options[:date] ||= default_options[:date]
      if File.exist? index_path_for(options)
        localize YAML.load(open(index_path_for(options)))
      else
        all_routes = []
        while schedule = find_one(options.merge(:route_index => all_routes.size))
          all_routes << schedule
        end
        open index_path_for(options), 'w' do |f|
          YAML.dump all_routes, f
        end

        find_all(options)
      end
    end
    
    def find_one (options={})
      source_code = read(options)
      decode(source_code)
    end

    def localize (schedules)
      schedules.each do |schedule|
        schedule[:departures].each do |departure|
          departure[:time] = departure[:time].in_time_zone
        end
      end
    end
 
    def decode (source_code)
      document = interpret(source_code)
      unless document.at('.InfoBeanError')
        schedule = {:legend => {}}

        header_rows = document.search("#StopTimesTimesSelectedTable > tr")
      
        date_text = header_rows[0].search(:td)[1].inner_text
        schedule.merge! :date => Date.parse(date_text)
      
        location_text = header_rows[2].search(:td)[1].inner_text
        schedule.merge! :location => extract_location_from(location_text)

        route_and_direction_text = header_rows[6].search(:td)[1].inner_text
        schedule.merge! extract_route_and_direction_from(route_and_direction_text)
      
        schedule[:destinations] = Hash.new(schedule[:direction])
        header_rows.slice(8, header_rows.size).each do |row|
          cells = row.search(:td)
          flag = /\[(.)\]/.match(cells[0].inner_text)[1]
          text = cells[1].inner_text
          if text.include?("Destination")
            schedule[:destinations][flag] = text.sub("Destination ", "")
          else
            schedule[:legend][flag] = text
          end
        end
        
        departure_texts = document.search("#StopTimesTimesListTable0 td").map {|cell| cell.inner_text.strip }
        schedule[:departures] = departure_texts.inject([]) do |departures, text|
          departures << extract_departure_from(text, schedule)
        end
        
        schedule[:headsigns] = schedule[:departures].map { |d| d[:destination] }.uniq
        
        return schedule
      end
    end
    
    def default_options
      {:route_index => 0, :date => Date.current}
    end
    
    def url_for (options={})
      options = default_options.merge(options)
      url = "#{site}/jnot/post.routelist.stoptimes.oci?"
      url << "rangeIndex=5&day=#{date_stamp(options[:date])}"
      url << "&stop=#{options[:location]}"
      url << "&check#{options[:route_index]}=on"
    end

    def path_for (options={})
      options = default_options.merge(options)
      "#{date_stamp(options[:date])}/location_#{options[:location]}_route_index_#{options[:route_index]}.html"
    end

    def index_path_for (options={})
      options = default_options.merge(options)
      case @source
      when :fixtures
        "#{fixtures_path}/#{date_stamp(options[:date])}/location_#{options[:location]}.yml"
      else
        "#{cache_path}/#{date_stamp(options[:date])}/location_#{options[:location]}.yml"
      end
    end
  end
end