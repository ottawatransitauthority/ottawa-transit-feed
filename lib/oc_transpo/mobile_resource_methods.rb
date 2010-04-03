require "hpricot"

module OCTranspo
  module MobileResourceMethods
    include RemoteResourceMethods
    
    def site
      "http://www.octranspo.com/mobileweb"
    end

    def date_stamp (date)
      date.strftime("%Y%m%d")
    end
    
    def default_options
      {:index => 0, :date => Date.current}
    end
    
    protected
    
    # Return a Hpricot DOM representing source_code.
    def interpret (source_code)
      Hpricot(convert_to_utf_8(source_code), :fixup_tags => true)
    end
    
    # Return a copy of source_code converted to UTF-8.
    def convert_to_utf_8 (source_code)
      Iconv.new('UTF-8', 'ISO-8859-1').iconv(source_code).sub('charset=iso-8859-1', 'charset=utf-8')
    end
    
    # TODO: Use Lingo instead of local regexps.
    def extract_route_and_direction_from (text)
      if matches = /OTrn (.+)/.match(text)
        {:route => "O-Train", :direction => matches[1].strip.mb_chars.upcase}
      elsif matches = /^SHTL SCOTIA BANK PLACE BANQUE SCOTIA/.match(text)
        {:route => nil, :direction => "SHUTTLE TO SCOTIA BANK PLACE BANQUE SCOTIA"}
      elsif matches = /(\d+) (.+)/.match(text)
        {:route => matches[1], :direction => matches[2].strip.mb_chars.upcase}
      else
        raise "Failed to extract route and direction: #{text}"
      end
    end
    
    # TODO: Use Lingo instead of local regexps.
    def extract_location_from (text)
      if matches = /(.+) ([1-9][A-E]) +\((\d\d\d\d)\)/.match(text)
        {:station => matches[1], :platform => matches[2], :number => matches[3], :name => "#{matches[1]} #{matches[2]}"}
      elsif matches = /(.+) \((\d\d\d\d)\)/.match(text)
        {:name => matches[1], :number => matches[2]}
      else
        {:name => text.strip}
      end
    end

    def extract_time_from (text, schedule)
      match = /(\d+):(\d+) (AM|PM)/.match(text)
      if match
        hour     = match[1].to_i
        minute   = match[2].to_i
        meridian = match[3]

        if meridian == "AM"
          if hour < 4
            hour = hour + 24
          end
        else
          unless hour == 12
            hour = hour + 12
          end
        end

        seconds_after_midnight = hour.hours.seconds + minute.minutes.seconds
        return Time.zone.parse(schedule[:date].to_s) + seconds_after_midnight
      end
    end
    
    def extract_departure_from (text, schedule)
      flags = extract_flags_from(text)
      destination_flag = schedule[:destinations].keys.detect { |key| flags.delete(key) }
      departure = {}
      departure[:time] = extract_time_from(text, schedule)
      departure[:destination] = schedule[:destinations][destination_flag]
      if flags.any?
        departure[:notes] = flags.map { |key| schedule[:legend][key] }
      end
      departure
    end
    
    def extract_flags_from (text)
      if flag_data = /\[(.+)\]/.match(text)
        flag_data[1].split("")
      else
        []
      end
    end
  end
end