module OttawaTransitFeed
  class Schema < ActiveRecord::Schema

    def self.connection
      Record.connection
    end
    
    def self.create
      define do
        create_table :agencies do |agency|
          agency.string :agency_id
          agency.string :name
          agency.string :url
          agency.string :phone
          agency.string :timezone
          agency.string :lang
        end

        create_table :calendars do |calendar|
          calendar.string :service_id
          %w(monday tuesday wednesday thursday friday saturday sunday).each { |day| calendar.string day }
          calendar.string :start_date
          calendar.string :end_date
        end
        
        create_table :calendar_dates do |calendar_date|
          calendar_date.string :service_id
          calendar_date.string :date
          calendar_date.string :exception_type
        end

        create_table :routes do |route|
          route.string :agency_id
          route.string :route_id
          route.string :route_type
          route.string :short_name
          route.string :long_name
          route.string :desc
        end

        add_index :routes, :route_id, :unique => true

        create_table :stop_times do |stop_time|
          stop_time.string :trip_id
          stop_time.string :stop_id
          stop_time.string :stop_sequence
          stop_time.string :arrival_time
          stop_time.string :departure_time
          stop_time.string :pickup_type
          stop_time.string :drop_off_type
        end
        
        add_index :stop_times, [:trip_id, :stop_sequence], :unique => true

        create_table :stops do |stop|
          stop.string :stop_id
          stop.string :zone_id
          stop.string :name
          stop.string :desc
          stop.string :url
          stop.string :code
          stop.string :lat
          stop.string :lon
          stop.string :street
          stop.string :city
          stop.string :region
          stop.string :country
          stop.string :postcode
          stop.string :original_name
        end

        add_index :stops, :stop_id, :unique => true

        create_table :trips do |stop|
          stop.string :trip_id
          stop.string :service_id
          stop.string :block_id
          stop.string :route_id
          stop.string :headsign_signature
          stop.string :original_route_id
          stop.string :original_headsign
        end
        
        add_index :trips, :trip_id, :unique => true

        create_table :headsigns do |headsign|
          headsign.string :string
          headsign.string :signature
          headsign.string :route_id
          headsign.text :stop_ids
        end

        add_index :headsigns, :signature, :unique => true
      end
    end
  end
end