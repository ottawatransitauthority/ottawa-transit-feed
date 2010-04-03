require "open-uri"

module OCTranspo
  module RemoteResourceMethods
    
    def read (options={})
      # puts url_for(options)
      case @source
      when :fixtures
        read_from_fixture(options)
      else
        read_from_cache(options) || cache(options)
      end
    end
    
    def read_from_remote (options)
      url = url_for(options)
      puts "Opening #{url}"
      open(url).read
    end
    
    def read_from_fixture (options)
      address = fixture_path_for(options)
      create_fixture(options) unless File.exist?(address)
      open(address).read
    end
    
    def read_from_cache (options)
      address = cache_path_for(options)
      if File.exist?(address)
        open(address).read
      end
    end
    
    def reset!
      @source = nil
    end
    
    def use_fixtures!
      @source = :fixtures
    end
    
    def site; end
    
    def url_for (options={}); end

    def path_for (options={}); end
    
    def fixture_path_for (options={}); 
      "#{fixtures_path}/#{path_for(options)}"
    end

    def cache_path_for (options={}); 
      "#{cache_path}/#{path_for(options)}"
    end
    
    def fixtures_path
      "test/fixtures/oc_transpo/#{self.name.demodulize.underscore}"
    end
    
    def cache_path
      "cache/oc_transpo/#{self.name.demodulize.underscore}"
    end
    
    def create_fixture (options={})
      address = fixture_path_for(options)
      puts "Creating fixture #{address}"
      system "mkdir -p #{File.dirname(address)}"
      File.open(address, "w") do |f|
        f.write read_from_remote(options)
      end
      read_from_fixture(options)
    end
    
    def cache (options={})
      address = cache_path_for(options)
      system "mkdir -p #{File.dirname(address)}"
      File.open(address, "w") do |f|
        f.write read_from_remote(options)
      end
      puts "Cached #{address}"
      read_from_cache(options)
    end
    
    def logger
      RAILS_DEFAULT_LOGGER
    end
  end
end