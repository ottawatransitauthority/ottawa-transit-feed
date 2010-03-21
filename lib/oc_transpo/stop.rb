require 'hpricot'

module OCTranspo
  module Stop
    extend self

    def all
      @stops ||= YAML.load_file(storage)
    end

    def find_by_stop_id (stop_id)
      stop_id = stop_id.to_s
      all.detect do |stop|
        stop[:stop_id] == stop_id
      end
    end

    def find_by_code (code)
      code = code.to_s
      all.detect do |stop|
        stop[:code] == code
      end
    end

    def find_all_by_code (code)
      code = code.to_s
      all.select do |stop|
        stop[:code] == code
      end
    end

    def find_by_name (name)
      all.detect do |stop|
        stop[:name] == name
      end
    end
    
    def find_all_by_name (name)
      all.select do |stop|
        stop[:name] == name
      end
    end

    def find_all_matching (pattern)
      all.select do |stop|
        pattern.match stop[:name]
      end
    end
    
    def update
      url = "http://www.octranspo1.com/google/retrieve_stops?zoom=15"
      doc = Hpricot.XML(open(url).read)
      new_stops = (doc / :marker).map do |marker|
        attributes = {}.merge(marker.attributes).symbolize_keys
        attributes[:stop_id] = attributes.delete(:stopid)
        attributes[:code] = attributes.delete(:id).rjust(4, "0")
        attributes[:code] = nil if attributes[:code] == "0000"
        attributes        
      end
      File.open(storage, 'w') { |f| f << YAML.dump(new_stops) }
      @stops = nil
      return all
    end
    
    def storage
      "#{File.dirname(__FILE__)}/stops.yml"
    end
  end
end