require 'hpricot'

module OCTranspo
  module Route
    extend self

    def all
      @routes ||= YAML.load_file(storage)
    end

    def find_by_route_id (route_id)
      find_by_number route_id.to_s.split('-').first
    end

    def find_by_number (number)
      all.detect do |route|
        route[:number] == number
      end
    end

    def find_all_matching (pattern)
      all.select do |route|
        pattern.match route[:name]
      end
    end
    
    def storage
      "#{File.dirname(__FILE__)}/routes.yml"
    end
  end
end