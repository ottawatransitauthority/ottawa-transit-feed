module OCTranspo
  module Lingo
    extend self

    def translate_location (lingo)
      lingo = lingo.strip.gsub("\\", "/")
      if landmark?     lingo: return translate_landmark(lingo)     end
      if platform?     lingo: return translate_platform(lingo)     end
      if address?      lingo: return translate_address(lingo)      end
      if intersection? lingo: return translate_intersection(lingo) end
      translate_landmark(lingo)
    end
    
    def inflect_location (lingo)
      lingo.mb_chars.downcase.titlecase
    end
    
    def landmark? (lingo)
      landmarks.key? lingo
    end
    
    def translate_landmark (lingo)
      landmarks[lingo] || inflect_location(lingo)
    end
    
    def translate_roadway (lingo)
      roadways[lingo] || translate_landmark(lingo)
    end
    
    def intersection? (lingo)
      if address?(lingo)
        false
      else
        extract_intersection_from(lingo) ? true : false
      end
    end
    
    def extract_intersection_from (lingo)
      if matched = lingo.match(/(.*) \/ (.*)/)
        [matched[1], matched[2]].map!(&:strip)
      end
    end
    
    def translate_intersection (lingo)
      extracted = extract_intersection_from(lingo).map { |part| translate_roadway(part) }
      "#{extracted.first} at #{extracted.last}"
    end

    def address? (lingo)
      extract_address_from(lingo) ? true : false
    end
    
    def extract_address_from (lingo)
      if matched = lingo.match(/(.*) \/ AD. (\d+)/)
        {:street => matched[1], :number => matched[2]}
      end
    end
    
    def translate_address (lingo)
      extracted = extract_address_from(lingo)
      "#{extracted[:number]} #{translate_roadway(extracted[:street])}"
    end
    
    def platform? (lingo)
      extract_platform_from(lingo) ? true : false
    end
    
    def extract_platform_from (lingo)
      extract_bus_platform_from(lingo) || extract_train_platform_from(lingo)
    end
    
    def extract_bus_platform_from (lingo)
      if matched = lingo.match(/(.+[A-Z]+) +(\d[A-E])$/)
        {:station => matched[1], :platform => matched[2]}
      end
    end
    
    def extract_train_platform_from (lingo)
      if matched = lingo.match(/^O-TRAIN CARLETON ([A-Z]).$/)
        platforms = {'S' => "Southbound", 'N' => "Northbound"}
        return {:station => "CARLETON", :platform => platforms[matched[1]]}
      end
      if matched = lingo.match(/^O-TRAIN (.+[A-Z]+)/)
        return {:station => matched[1], :platform => "O-Train"}
      end
    end
    
    def bus_platform_number_pattern
      /[1-9][A-E]/
    end
    
    def format_platform (platform)
      if platform.match(bus_platform_number_pattern)
        "Platform #{platform}"
      else
        "#{platform} Platform"
      end
    end
    
    def translate_platform (lingo)
      extracted = extract_platform_from(lingo)
      "#{translate_landmark(extracted[:station])}, #{format_platform extracted[:platform]}"
    end
    
    [:landmarks, :roadways].each do |collection|
      module_eval <<-END
        def #{collection}
          @#{collection} ||= YAML.load_file("#{File.dirname(__FILE__)}/lingo/#{collection}.yml")
        end
      END
    end
  end
end