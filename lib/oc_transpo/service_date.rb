module OCTranspo
  module ServiceDate
    
    def service_date
      service_date_for Time.current
    end

    def service_date_for (time)
      case time.hour
      when 0..3
        time.yesterday.to_date
      else
        time.to_date
      end
    end
  end
end