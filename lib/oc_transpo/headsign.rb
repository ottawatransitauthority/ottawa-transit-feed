module OCTranspo
  module Headsign
    extend self

    def find (route_number, heading, stops)
      if route_number && heading && stops.any?
        selector = "route_#{route_number}"
        send selector, heading, stops if respond_to? selector
      end
    end
  
    def route_1 (heading, stops)
      case stops.last[:code]
      when "8789" # Maple Grove Rd. at Springfield Rd.
        "1 OTTAWA ROCKCLIFFE"
      when "3009" # Rideau Centre
        "1X DOWNTOWN"
      when "3037" # Greenboro Station
        "1 SOUTH KEYS"
      when "3034" # Billings Bridge Station
        "1X BILLINGS BRIDGE"
      end
    end

    def route_2 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "2 BAYSHORE"
      when "3012" # Westboro Station
        "2 WESTBORO"
      when "3009" # Rideau Centre
        "2 DOWNTOWN"
      end
    end

    def route_3 (heading, stops)
      case stops.last[:code]
      when "5693" # 177 Colonnade Rd.
        "3 COLONNADE"
      when "2975" # Merivale Rd. & Viewmount Dr.
        "3X NEPEAN CENTRE"
      when "3009" # Rideau Centre
        "3 DOWNTOWN"
      end
    end

    def route_4 (heading, stops)
      case stops.last[:code]
      when "3009" # Rideau Centre
        "4 DOWNTOWN"
      when "3023" # Hurdman Station
        "4 HURDMAN"
      when "5813" # Campus Ave. & Library Rd.
        "4X CARLETON"
      end
    end

    def route_5 (heading, stops)
      case stops.last[:code]
      when "3034" # Billings Bridge Station
        "5 BILLINGS BRIDGE"
      when "3025" # St. Laurent Station
        "5 ST. LAURENT"
      when "3009" # Rideau Centre
        "5X DOWNTOWN"
      when "6799" # Main St. & Lees Ave
        "5X IMMACULATA HIGH SCHOOL"
      end
    end

    def route_6 (heading, stops)
      case stops.last[:code]
      when "3009" # Rideau Centre
        "6 DOWNTOWN"
      when "3011" # Tunney’s Pasture Station
        "6 TUNNEY’S PASTURE"
      end
    end

    def route_7 (heading, stops)
      case stops.last[:code]
      when "5813" # Campus Ave. & Library Rd.
        "7 CARLETON"
      when "3009" # Rideau Centre
        "7X DOWNTOWN"
      when "2488" # Bank St. & Somerset St.
        "7X DOWNTOWN"
      when "3025" # St. Laurent Station
        "7 ST. LAURENT"
      when "1895" # Montreal Rd. & Brittany Dr.
        "7X OTTAWA ROCKCLIFFE"
      end
    end

    def route_8 (heading, stops)
      case stops.last[:code]
      when "3034" # Billings Bridge Station
        "8 BILLING BRIDGE"
      when "3023" # Hurdman Station
        "8X HURDMAN"
      when "1940" # Rue Laurier & Rue Élisabeth-Bruyère
        "8 HULL"
      when "5718" # Promenade Ave. & Terrasses de la Chaudière
        "8X TERRASSES DE LA CHAUDIÈRE"
      when "3010" # Lebreton Station
        "8X LEBRETON"
      end
    end
  
    def route_9 (heading, stops)
      case stops.last[:code]
      when "7687" # Bank St. & Slater St.
        "9 DOWNTOWN"
      when "3023" # Hurdman Station
        "9 HURDMAN"
      when "8764" # Crichton St. & Beechwood Ave.
        "9X OTTAWA ROCKCLIFFE"
      end
    end

    def route_12 (heading, stops)
      case stops.last[:code]
      when "7687" # Bank St. & Slater St.
        "12 DOWNTOWN"
      when "3009" # Rideau Centre
        "12X RIDEAU CENTRE"
      when "3027" # Blair Station
        "12 BLAIR"
      end
    end

    def route_14 (heading, stops)
      case stops.last[:code]
      when "4824" # Caldwell Ave. & Medford
        "14 CARLINGTON"
      when "8019" # Carling Ave. & Holland Ave.
        "14X CARLING & HOLLAND"
      when "3025" # St. Laurent Station
        "14 ST. LAURENT"
      when "3009" # Rideau Centre
        "14X DOWNTOWN"
      end
    end

    def route_15 (heading, stops)
      case stops.last[:code]
      when "3014" # Lincoln Fields Station
        "15 LINCOLN FIELDS"
      when "7558" # Elgin St. & Queen St.
        "15X DOWNTOWN"
      when "3027" # Blair Station
        "15 BLAIR"
      end
    end

    def route_16 (heading, stops)
      case stops.last[:code]
      when "2796" # Britania Park
        "16 BRITANNIA"
      when "5889" # Carlingwood Mall
        "16 CARLINGWOOD"
      when "3014" # Lincoln Fields Station
        "16 LINCOLN FIELDS"
      when "3009" # Rideau Centre
        "16X DOWNTOWN"
      when "1591" # Ottawa Hospital Rehabilitation Centre
        "16 ALTA VISTA"
      when "3011" # Tunney’s Pasture Station
        "16X TUNNEY’S PASTURE"
      when "6809" # Main St. & Evelyn Ave
        "16X IMMACULATA HIGH SCHOOL"
      end
    end

    def route_18 (heading, stops)
      case stops.last[:code]
      when "2796" # Britannia Park
        "18 BRITANNIA"
      when "3014" # Lincoln Fields Station
        "18X LINCOLN FIELDS"
      when "3009" # Rideau Centre
        "18X DOWNTOWN"
      when "3025" # St. Laurent Station
        "18 ST. LAURENT"
      when "6647" # Albert St. & Booth St.
        "18 BAYVIEW"
      end
    end

    def route_20 (heading, stops)
      case stops.last[:code]
      when "0355" # Portobello Blvd. & Blackburn Bypass Extension
        "20 CUMBERLAND"
      when "3010" # Lebreton Station
        "20 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "20X LINCOLN FIELDS"
      end
    end

    def route_21 (heading, stops)
      case stops.last[:code]
      when "0793" # Innes Rd. & Du Grand Bois Ave
        "21 CUMBERLAND"
      when "3010" # Lebreton Station
        "21 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "21X LINCOLN FIELDS"
      end
    end

    def route_22 (heading, stops)
      case stops.last[:code]
      when "6304" # Provence Ave. & Valin St
        "22 CUMBERLAND"
      when "3010" # Lebreton Station
        "22 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "22X LINCOLN FIELDS"
      end
    end

    def route_23 (heading, stops)
      case stops.last[:code]
      when "1194" # Innes Rd. & Page Rd.
        "23 GLOUCESTER NORTH"
      when "3010" # Lebreton Station
        "23 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "23X LINCOLN FIELDS"
      end
    end

    def route_24 (heading, stops)
      case stops.last[:code]
      when "8189" # La Verendrye Dr. & Ogilvie Rd.
        "24 GLOUCESTER NORTH"
      when "3010" # Lebreton Station
        "24 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "24X LINCOLN FIELDS"
      end
    end

    def route_25 (heading, stops)
      case stops.last[:code]
      when "1866" # Innes Rd. & Blackburn Hamlet Bypass
        "25 GLOUCESTER NORTH"
      when "3010" # Lebreton Station
        "25 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "25X LINCOLN FIELDS"
      end
    end

    def route_27 (heading, stops)
      case stops.last[:code]
      when "0358" # Esprit Dr. & Blackburn Bypass Extension
        "27 CUMBERLAND"
      when "5718" # 5718: Promenade Ave. & Terrasses de la Chaudière
        "27 HULL"
      end
    end

    def route_29 (heading, stops)
      case stops.last[:code]
      when "3010" # Lebreton Station
        "29 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "29X LINCOLN FIELDS"
      when "8717" # Hemlock Rd. & London Terrace
        "29 OTTAWA ROCKCLIFFE"
      end
    end

    def route_30 (heading, stops)
      case stops.last[:code]
      when "6164" # Innes Rd. & Portobello Blvd
        "30 CUMBERLAND"
      when "3010" # Lebreton Station
        "30 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "30X LINCOLN FIELDS"
      end
    end

    def route_31 (heading, stops)
      case stops.last[:code]
      when "3010" # Lebreton Station
        "31 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "31X LINCOLN FIELDS"
      when "7957" # Orléans Blvd. & Innes Rd.
        "31 GLOUCESTER NORTH"
      end
    end

    def route_32 (heading, stops)
      case stops.last[:code]
      when "3010" # Lebreton Station
        "32 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "32X LINCOLN FIELDS"
      when "3375" # Lakeridge Dr. & Lakeridge Dr.
        "32 CUMBERLAND"
      end
    end

    def route_33 (heading, stops)
      case stops.last[:code]
      when "3010" # Lebreton Station
        "33 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "33X LINCOLN FIELDS"
      when "2645" # Innes Rd. & Orléans Blvd.
        "33 GLOUCESTER NORTH"
      end
    end

    def route_34 (heading, stops)
      case stops.last[:code]
      when "3010" # Lebreton Station
        "34 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "34X LINCOLN FIELDS"
      when "2645" # Innes Rd. & Orléans Blvd.
        "34 GLOUCESTER NORTH"
      end
    end

    def route_35 (heading, stops)
      case stops.last[:code]
      when "7851" # Innes Rd. & Orchardview Ave.
        "35 CUMBERLAND"
      when "3010" # Lebreton Station
        "35 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "35X LINCOLN FIELDS"
      end
    end

    def route_36 (heading, stops)
      case stops.last[:code]
      when "1828" # 3474 St. Joseph Blvd.
        "36 CUMBERLAND"
      when "3010" # Lebreton Station
        "36 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "36X LINCOLN FIELDS"
      end
    end

    def route_37 (heading, stops)
      if stops.last[:stop_id] == "EP960" # Orléans Park & Ride
        "37 GLOUCESTER NORTH"
      else
        case stops.last[:code]
        when "3010" # Lebreton Station
          "37 DOWNTOWN"
        when "3014" # Lincoln Fields Station
          "37X LINCOLN FIELDS"
        end
      end
    end

    def route_38 (heading, stops)
      case stops.last[:code]
      when "7965" # Tenth Line Rd. & Regional Road 174
        "38 CUMBERLAND"
      when "3010" # Lebreton Station
        "38 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "38X LINCOLN FIELDS"
      end
    end

    def route_39 (heading, stops)
      case stops.last[:code]
      when "6353" # Trim Rd. & Regional Road 174
        "39 CUMBERLAND"
      when "3010" # Lebreton Station
        "39 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "39X LINCOLN FIELDS"
      end
    end

    def route_40 (heading, stops)
      case stops.last[:code]
      when "8953" # Queensdale Ave. & Conroy Rd.
        "40 GLOUCESTER SOUTH"
      when "5718" # Promenade Ave. & Terrasses de la Chaudière
        "40 HULL"
      end
    end

    def route_43 (heading, stops)
      case stops.last[:code]
      when "3330" # Conroy Rd. & Johnston Rd.
        "43 OTTAWA SOUTH"
      when "3010" # Lebreton Station
        "43 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "43X LINCOLN FIELDS"
      end
    end

    def route_45 (heading, stops)
      case stops.last[:code]
      when "3010" # Lebreton Station
        "45 DOWNTOWN"
      when "3741" # Prince Of Wales Dr. & Danbury Way
        "45 RIDEAU"
      when "1496" # Dr Leach Dr. & Aréna Manotick Arena
        "45X NORTH GOWER"
      end
    end

    def route_50 (heading, stops)
      case stops.last[:code]
      when "2796" # Britannia Park
        "50 BRITANNIA"
      when "3023" # Hurdman Station
        "50 DOWNTOWN"
      when "3027" # Blair Station
        "50X BLAIR"
      end
    end

    def route_51 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "51 DOWNTOWN"
      when "0318" # Iris St. & Transitway
        "51 IRIS"
      end
    end

    def route_55 (heading, stops)
      case stops.last[:code]
      when "3017" # Baseline Station
        "55 BASELINE"
      when "3023" # Hurdman Station
        "55 DOWNTOWN"
      when "3027" # Blair Station
        "55X BLAIR"
      end
    end

    def route_57 (heading, stops)
      case stops.last[:code]
      when "3017" # Baseline Station
        "57 BASELINE"
      when "3023" # Hurdman Station
        "57 DOWNTOWN"
      when "3027" # Blair Station
        "57X BLAIR"
      end
    end

    def route_59 (heading, stops)
      case stops.last[:code]
      when "5326" # Grandview Rd. & Borden
        "59 NEPEAN NORTH"
      when "3023" # Hurdman Station
        "59 DOWNTOWN"
      when "3027" # Blair Station
        "59X BLAIR"
      end
    end

    def route_60 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "60 DOWNTOWN"
      when "3027" # Blair Station
        "60X BLAIR"
      when "6158" # Terry Fox Dr. & Helmsdale Dr.
        "60 KANATA"
      end
    end

    def route_61 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "61 DOWNTOWN"
      when "3027" # Blair Station
        "61X BLAIR"
      when "0610" # Pine Hill Rd. & Stonehaven Dr.
        "61 KANATA"
      end
    end

    def route_62 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "62 DOWNTOWN"
      when "3027" # Blair Station
        "62X BLAIR"
      when "6242" # Hazeldean Mall
        "62 KANATA"
      end
    end

    def route_63 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "63 DOWNTOWN"
      when "3027" # Blair Station
        "63X BLAIR"
      when "6242" # Hazeldean Mall
        "63 KANATA"
      end
    end

    def route_64 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "64 DOWNTOWN"
      when "3027" # Blair Station
        "64X BLAIR"
      when "6298" # Hazeldean Rd. & Carbrooke St.
        "64 KANATA"
      end
    end

    def route_65 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "65 DOWNTOWN"
      when "3027" # Blair Station
        "65X BLAIR"
      when "1813" # Campeau Dr. & Teron Rd.
        "65 KANATA"
      end
    end

    def route_66 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "66 DOWNTOWN"
      when "3027" # Blair Station
        "66X BLAIR"
      when "1926" # Cadence Gate & Equestrian Dr.
        "66 KANATA"
      end
    end

    def route_67 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "67 DOWNTOWN"
      when "3027" # Blair Station
        "67X BLAIR"
      when "2539" # 389 Siskins
        "67 NEPEAN CENTRE"
      end
    end

    def route_68 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "68 DOWNTOWN"
      when "3027" # Blair Station
        "68X BLAIR"
      when "0339" # Kanata Ave. & Terry Fox Dr.
        "68 KANATA"
      end
    end

    def route_69 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "69 DOWNTOWN"
      when "3027" # Blair Station
        "69X BLAIR"
      when "0944" # Westcliffe Rd. & Oberon St.
        "69 NEPEAN CENTRE"
      end
    end

    def route_70 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "70 DOWNTOWN"
      when "3027" # Blair Station
        "70X BLAIR"
      when "3394" # Kennevale Dr. & Cobble Hill
        "70 NEPEAN SOUTH"
      end
    end

    def route_71 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "71 DOWNTOWN"
      when "3027" # Blair Station
        "71X BLAIR"
      when "3044" # Strandherd Station
        "71 NEPEAN SOUTH"
      end
    end

    def route_73 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "73 DOWNTOWN"
      when "3027" # Blair Station
        "73X BLAIR"
      when "3044" # Strandherd Station
        "73 NEPEAN SOUTH"
      end
    end

    def route_76 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "76 DOWNTOWN"
      when "3027" # Blair Station
        "76X BLAIR"
      when "5453" # Cedarview Rd. & Jockvale Rd.
        "76 NEPEAN SOUTH"
      end
    end

    def route_77 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "77 DOWNTOWN"
      when "3753" # Leikin Dr. & Bill Leathem Dr.
        "77 NEPEAN SOUTH"
      end
    end

    def route_82 (heading, stops)
      case stops.last[:code]
      when "8399" # 1680 Walkley Rd.
        "82 ALTA VISTA"
      when "3011" # Tunney’s Pasture Station
        "82 TUNNEY’S PASTURE"
      end
    end

    def route_85 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "85 BAYSHORE"
      when "3023" # Hurdman Station
        "85 HURDMAN"
      end
    end

    def route_86 (heading, stops)
      case stops.last[:code]
      when "0643" # Southvale Crescent & Russell Rd.
        "86 ELMVALE"
      when "3023" # Hurdman Station
        "86X HURDMAN"
      when "3014" # Lincoln Fields Station
        "86 LINCOLN FIELDS"
      when "3010" # Lebreton Station
        "86X DOWNTOWN"
      end
    end

    def route_87 (heading, stops)
      case stops.last[:code]
      when "1827" # Carlingwood Mall
        "87 CARLINGWOOD"
      when "3023" # Hurdman Station
        "87X HURDMAN"
      when "3010" # Lebreton Station
        "87X DOWNTOWN"
      when "3037" # Greenboro Station
        "87 SOUTH KEYS"
      end
    end

    def route_88 (heading, stops)
      case stops.last[:code]
      when "1304" # Allumettières & Champlain Rd.
        "88 HULL"
      when "3038" # South Keys Station
        "88 SOUTH KEYS"
      end
    end

    def route_94 (heading, stops)
      case stops.last[:code]
      when "3076" # Millennium Blvd. & Park Rd.
        "94 MILLENNIUM"
      when "3242" # Innes Rd. & Trim Rd.
        "94X INNES"
      when "3011" # Tunney’s Pasture Station
        "94 TUNNEY’S PASTURE"
      when "3010" # Lebreton Station
        "94X LEBRETON"
      end
    end

    def route_95 (heading, stops)
      case stops.last[:code]
      when "3043" # Fallowfield Station
        "95 FALLOWFIELD"
      when "3017" # Baseline Station
        "95X BASELINE"
      when "1388" # Market Place & Greenbank Rd.
        "95X BARRHAVEN CENTRE"
      when "3028" # Place d’Orléans Station
        "95 ORLEANS"
      when "3029" # Trim Station
        "95X TRIM"
      end
    end

    # TODO: Figure out how to detect D96 SPECIAL DIRECT VIA 417 headsign
    def route_96 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "96 HURDMAN"
      when "3058" # Terry Fox Station
        "96 KANATA"
      when "2061" # Abbott St. & Granite Ridge Dr.
        "96X STITTSVILLE"
      when "0659" # Iber Rd. & Harry Douglas Dr.
        "96X STITTSVILLE"
      end
    end

    def route_97 (heading, stops)
      case stops.last[:code]
      when "3039" # Ottawa International Airport
        "97 AIRPORT"
      when "8677" # Hunt Club Loop
        "97X SOUTH KEYS"
      when "3050" # Bayshore Station
        "97 BAYSHORE"
      when "3011" # Tunney’s Pasture Station
        "97X TUNNEY’S PASTURE"
      when "1169" # 230 Woodridge Crescent
        "97X NEPEAN NORTH"
      end
    end

    def route_98 (heading, stops)
      case stops.last[:code]
      when "9069" # Hawthorne Rd. & Hunt Club Rd.
        "98 HAWTHORNE"
      when "3011" # Tunney’s Pasture Station
        "98 TUNNEY’S PASTURE"
      when "3037" # Greenboro Station
        "98X SOUTH KEYS"
      end
    end

    def route_101 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "101 BAYSHORE"
      when "0648" # Herzberg Rd. & March Rd.
        "101X KANATA NORTH"
      when "3028" # Place d’Orléans Station
        "101 ORLEANS"
      when "3015" # Queensway Station
        "101X QUEENSWAY"
      end
    end

    def route_102 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "102 ORLEANS"
      when "3011" # Tunney’s Pasture Station
        "102 TUNNEY’S PASTURE"
      end
    end

    def route_103 (heading, stops)
      case stops.last[:code]
      when "7118" # 360 Coventry Rd.
        "103 OVERBROOK"
      when "3023" # Hurdman Station
        "103 HURDMAN"
      end
    end
  
    # TODO: Incomplete due to incomplete dataset
    def route_105 (heading, stops)
      case stops.last[:code]
      when "5718" # Promenade Ave. & Terrasses de la Chaudière
        "105 HULL"
      when "3011" # Tunney’s Pasture Station
        "105 TUNNEY’S PASTURE"
      end
    end
  
    def route_106 (heading, stops)
      case stops.last[:code]
      when "8810" # Elmvale Mall
        "106 ELMVALE"
      when "7234" # Ottawa General Hospital
        "106X ALTA VISTA"
      when "3023" # Hurdman Station
        "106 HURDMAN"
      end
    end

    def route_111 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "111 HURDMAN"
      when "3014" # Lincoln Fields Station
        "111 LINCOLN FIELDS"
      end
    end

    def route_112 (heading, stops)
      case stops.last[:code]
      when "3034" # Billings Bridge Station
        "112 BILLINGS BRIDGE"
      when "8810" # Elmvale Mall
        "112 ELMVALE"
      end
    end

    def route_114 (heading, stops)
      case stops.last[:code]
      when "3037" # Greenboro Station
        "114 GREENBORO"
      when "8810" # Elmvale Mall
        "114X ELMVALE"
      when "4307" # St. Laurent Blvd. & Conroy Rd.
        "114X ST. LAURENT & CONROY"
      when "3023" # Hurdman Station
        "114 HURDMAN"
      end
    end

    def route_115 (heading, stops)
      case stops.last[:code]
      when "3034" # Billings Bridge Station
        "115 BILLINGS BRIDGE"
      when "8233" # Heron Rd. & Clover St.
        "115 HERON PARK"
      end
    end

    def route_116 (heading, stops)
      case stops.last[:code]
      when "3017", "2315" # Baseline Station or Woodroffe Ave. at Parkglen
        "116 BASELINE"
      when "3014" # Lincoln Fields Station
        "116X LINCOLN FIELDS"
      when "7963" # Nortel Carling & Lab #7
        "116X NEPEAN NORTH"
      when "3037" # Greenboro Station
        "116 SOUTH KEYS"
      when "3023" # Hurdman Station
        "116X HURDMAN"
      end
    end

    def route_117 (heading, stops)
      case stops.last[:code]
      when "3017" # Baseline Station
        "117 BASELINE"
      when "5813" # Campus Ave. & Library Rd.
        "117 CARLETON"
      end
    end

    def route_118 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "118 HURDMAN"
      when "3028" # Place d’Orléans Station
        "118X ORLEANS"
      when "3058" # Terry Fox Station
        "118 KANATA"
      when "3017" # Baseline Station
        "118X BASELINE"
      when "5287" # Robertson Rd. & Moodie Dr.
        "118X NEPEAN CENTRE"
      end
    end

    def route_121 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "121 HURDMAN"
      when "3025" # St. Laurent Station
        "121 ST. LAURENT"
      end
    end

    def route_123 (heading, stops)
      case stops.last[:code]
      when "3027" # Blair Station
        "123 GLOUCESTER NORTH"
      end
    end

    def route_124 (heading, stops)
      case stops.last[:code]
      when "8707" # La Verendrye Dr. & Ogilvie Rd.
        "124 GLOUCESTER NORTH"
      when "0549" # Kender Ave. & Ogilvie Rd.
        "124X COLONEL BY HIGH SCHOOL"
      when "3023" # Hurdman Station
        "124 HURDMAN"
      when "3027" # Blair Station
        "124X BLAIR"
      when "3010" # Lebreton Station
        "124X DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "124X LINCOLN FIELDS"
      end
    end

    def route_125 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "125 HURDMAN"
      when "3028" # Place d’Orléans Station
        "125 ORLEANS"
      when "8672" # Cyrville Rd. & Maxime St.
        "125X DND"
      end
    end

    def route_126 (heading, stops)
      case stops.last[:code]
      when "8500" # Maxime St. & Cyrville Rd.
        "126 GLOUCESTER NORTH"
      when "3023" # Hurdman Station
        "126 HURDMAN"
      when "3027" # Blair Station
        "126X BLAIR"
      end
    end

    def route_127 (heading, stops)
      case stops.last[:code]
      when "3025" # St. Laurent Station
        "127 ST. LAURENT"
      when "3028" # Place d’Orléans Station
        "127 ORLEANS"
      when "3027" # Blair Station
        "127X BLAIR"
      end
    end

    def route_128 (heading, stops)
      last_stop = locations.last
      case 
      when last_stop.number == "3023" # Hurdman Station
        "128 HURDMAN"
      when last_stop.number == "3027" # Blair Station
        "128 BLAIR"
      when last_stop.official_id == "EH493" # Blackburn Arena
        "128 BLACKBURN ARENA"
      when last_stop.number == "8678" # Tauvette St. & Innes Rd
        "128 BLACKBURN HAMLET"
      end
    end

    def route_129 (heading, stops)
      case stops.last[:code]
      when "8835" # Aviation Museum
        "129 OTTAWA ROCKCLIFFE"
      when "0969" # Carson’s Rd. & Montreal Rd.
        "129X CARSON & MONTREAL"
      when "3023" # Hurdman Station
        "129 HURDMAN"
      when "3027" # Blair Station
        "129X BLAIR"
      end
    end

    def route_130 (heading, stops)
      case heading
      when "Convent Glen"
        case stops.last[:code]
        when "3028" # Place d’Orléans Station
          "130 CONVENT GLEN"
        when "5833" # St. Joseph Blvd. & Grey Nuns Dr.
          "130X ST. JOSEPH & GREY NUNS"
        end
      when "Fallingbrook"
        case stops.last[:code]
        when "3028" # Place d’Orléans Station
          "130 FALLINGBROOK"
        when "8167" # Jeanne d’Arc Blvd. & Champlain Rd.
          "130X JEANNE D’ARC & CHAMPLAIN"
        end
      end
    end

    def route_131 (heading, stops)
      case heading
      when "Chapel Hill"
        case stops.last[:code]
        when "3028" # Place d’Orléans Station
          "131 CHAPEL HILL"
        end
      when "Convent Glen"
        case stops.last[:code]
        when "3028" # Place d’Orléans Station
          "131 CONVENT GLEN"
        end
      end
    end

    def route_135 (heading, stops)
      case stops.last[:code]
      when "6475" # Tenth Line Rd. & Innes Rd.
        "135 AVALON"
      when "7895" # Charlemagne Blvd. & Merkley
        "135X ST. PETER’S HIGH SCHOOL"
      when "3028" # Place d’Orléans Station
        "135 PLACE D’ORLÉANS"
      when "3375" # Lakeridge Dr. & Lakeridge Dr.
        "135 ESPRIT"
      end
    end

    def route_136 (heading, stops)
      case stops.last[:code]
      when "0476" # Valin St. & Trim Rd.
        "136 FALLINGBROOK"
      when "3028" # Place d’Orléans Station
        "136 PLACE D’ORLÉANS"
      end
    end

    def route_137 (heading, stops)
      case heading
      when "Queenswood Heights"
        case stops.last[:code]
        when "3028" # Place d’Orléans Station
          "137 QUEENSWOOD HEIGHTS"
        end
      end
    end

    def route_140 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "140 HURDMAN"
      when "3034" # Billings Bridge Station
        "140X BILLINGS BRIDGE"
      when "8677" # Hunt Club Loop
        "140 SOUTH KEYS"
      end
    end

    def route_141 (heading, stops)
      case stops.last[:code]
      when "8391" # Walkley Rd. & Ryder St.
        "141 ALTA VISTA"
      when "3034" # Billings Bridge Station
        "141 BILLINGS BRIDGE"
      end
    end

    def route_142 (heading, stops)
      case stops.last[:code]
      when "8953" # Queensdale Ave. & Conroy Rd.
        "142 GLOUCESTER SOUTH"
      when "3037" # Greenboro Station
        "142 SOUTH KEYS"
      end
    end

    def route_143 (heading, stops)
      case stops.last[:code]
      when "3080" # Conroy Rd. & Johnston Rd.
        "143 LOCAL EAST"
      when "3037" # Greenboro Station
        "143 SOUTH KEYS"
      end
    end

    def route_144 (heading, stops)
      if stops.last[:stop_id] == "RH758" # Kelly Farm & Bradwell
        "144 GLOUCESTER SOUTH"
      else
        case stops.last[:code]
        when "1069" # 4835 Bank St.
          "144X HINDU TEMPLE"
        when "3037" # Greenboro Station
          "144 SOUTH KEYS"
        end
      end
    end

    def route_145 (heading, stops)
      case stops.last[:code]
      when "0653" # Riverside South Plaza & River Rd.
        "145 RIVERSIDE SOUTH"
      when "2128" # River Rd. & Balmoral Dr.
        "145X GLOUCESTER SOUTH"
      when "4341" # Leitrim Rd. & River Rd.
        "145X GLOUCESTER SOUTH"
      when "3037" # Greenboro Station
        "145 GREENBORO"
      end
    end

    def route_146 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "146 HURDMAN"
      when "3034" # Billings Bridge Station
        "146X BILLINGS BRIDGE"
      when "3037" # Greenboro Station
        "146 SOUTH KEYS"
      end
    end

    def route_147 (heading, stops)
      case heading
      when "Gloucester South / sud or/ou South Keys"
        case stops.last[:code]
        when "3037" # Greenboro Station
          "147 GLOUCESTER SOUTH"
        end
      end
    end

    def route_148 (heading, stops)
      case stops.last[:code]
      when "8813" # Elmvale Mall
        "148 ELMVALE"
      when "0540" # Canterbury Ave. & Canterbury H.S.
        "148X CANTERBURY HIGH SCHOOL"
      when "3023" # Hurdman Station
        "148 HURDMAN"
      when "3034" # Billings Bridge Station
        "148X BILLINGS BRIDGE"
      end
    end

    def route_149 (heading, stops)
      case stops.last[:code]
      when "8810" # Elmvale Mall
        "149 ELMVALE"
      when "3023" # Hurdman Station
        "149 HURDMAN"
      end
    end

    def route_151 (heading, stops)
      case stops.last[:code]
      when "4960" # Carlingwood Mall
        "151 CARLINGWOOD"
      when "3011" # Tunney’s Pasture Station
        "151 TUNNEY’S PASTURE"
      end
    end

    def route_152 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "152 BAYSHORE"
      when "3014" # Lincoln Fields Station
        "152 LINCOLN FIELDS"
      end
    end

    def route_153 (heading, stops)
      case stops.last[:code]
      when "3010" # Lebreton Station
        "153 LEBRETON"
      when "7677" # Gladstone Ave. & Cartier St.
        "153 SOMERSET"
      end
    end

    def route_154 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "154 BAYSHORE"
      when "3014" # Lincoln Fields Station
        "154 LINCOLN FIELDS"
      end
    end

    def route_156 (heading, stops)
      case stops.last[:stop_id]
      when "NI935" # Lincoln Fields Station, Platform 3B
        "156 LINCOLN HEIGHTS"
      when ""
        "156 MERIVALE"
      end
      # case heading
      # when "LOCAL NORTH / NORD"
      #   case stops.last[:code]
      #   when "3014" # Lincoln Fields Station
      #     "156 LOCAL NORTH"
      #   when "4960" # Carlingwood Mall
      #     "156X CARLINGWOOD"
      #   when "1636" # Merivale Rd. & Woodfield Dr.
      #     "156X NEPEAN CENTRE"
      #   when "4022" # Merivale Rd. & Viewmount Dr.
      #     "156X MERIVALE & VIEWMOUNT"
      #   when "4030" # Meadowlands Dr. & Merivale Rd.
      #     "156X MEADOWLANDS & MERIVALE"
      #   end
      # when "LOCAL SOUTH / SUD"
      #   case stops.last[:code]
      #   when "3014" # Lincoln Fields Station
      #     "156 LOCAL SOUTH"
      #   when "3023" # Hurdman Station
      #     "156X DOWNTOWN"
      #   end
      # end
    end

    def route_157 (heading, stops)
      case stops.last[:code]
      when "3017" # Baseline Station
        "157 BASELINE"
      when "6110" # Grenfell Crescent & Burnbank St.
        "157 NEPEAN CENTRE"
      end
    end

    def route_158 (heading, stops)
      case stops.last[:code]
      when "9038" # Colonnade Rd. & 181 Colonnade
        "158 NEPEAN CENTRE"
      when "3023" # Hurdman Station
        "158 HURDMAN"
      end
    end

    def route_160 (heading, stops)
      case stops.last[:code]
      when "6202" # Helmsdale Dr. & Shirley’s Brook Dr.
        "160 MORGAN’S GRANT"
      when "3058" # Terry Fox Station
        "160 TERRY FOX"
      end
    end

    def route_161 (heading, stops)
      case stops.last[:code]
      when "6217" # Stonehaven Dr. & Bridlewood Dr.
        "161 BRIDLEWOOD"
      when "1937" # Rothesay Dr. & Eagleson Rd.
        "161X ROTHESAY & EAGLESON"
      when "3058" # Terry Fox Station
        "161 TERRY FOX"
      end
    end

    def route_162 (heading, stops)
      case stops.last[:code]
      when "9056" # Maxwell Bridge & Windance
        "162 BROOKSIDE"
      when "3055" # Eagleson Station
        "162 EAGLESON"
      end
    end

    def route_163 (heading, stops)
      case stops.last[:code]
      when "3055" # Eagleson Station
        "163 KANATA"
      when "3370" # Huntmar Rd. & Burnaby
        "163 LOCAL WEST"
      end
    end

    def route_164 (heading, stops)
      case stops.last[:code]
      when "6222" # Grassy Plains Dr. & Farmfield Crescent
        "164 BRIDLEWOOD"
      when "3058" # Terry Fox Station
        "164 TERRY FOX"
      end
    end

    def route_165 (heading, stops)
      case stops.last[:code]
      when "3058" # Terry Fox Station
        "165 TERRY FOX"
      end
    end

    def route_166 (heading, stops)
      case heading
      when "Nepean Centre - Bayshore"
        case stops.last[:code]
        when "3050" # Bayshore Station
          "166 NEPEAN CENTRE"
        end
      when "Nepean North / nord - Bayshore"
        case stops.last[:code]
        when "3050" # Bayshore Station
          "166 NEPEAN NORTH"
        end
      end
    end

    def route_167 (heading, stops)
      case stops.last[:code]
      when "6241" # Michael Cowplan & Terence Matthews Crescent
        "167 KANATA"
      when "3014" # Lincoln Fields Station
        "167 LINCOLN FIELDS"
      end
    end

    def route_168 (heading, stops)
      case stops.last[:code]
      when "4807" # Terry Fox Dr. & McKinley Dr.
        "168 KANATA NORTH"
      when "0383" # Beaverbrook Rd. & Leacock Dr.
        "168X BEAVERBROOK"
      when "3058" # Terry Fox Station
        "168 TERRY FOX"
      end
    end

    def route_169 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "169 BAYSHORE"
      when "1382" # 301 Terry Fox Dr.
        "169X KANATA NORTH"
      when "6209" # Steeplechase & Sprucemeadow
        "169 KANATA"
      when "3055" # Eagleson Station
        "169X EAGLESON"
      end
    end

    def route_170 (heading, stops)
      case heading
      when "Longfields"
        case stops.last[:code]
        when "3043" # Fallowfield Station
          "170 LONGFIELDS"
        end
      when "Walter Baker"
        case stops.last[:code]
        when "3043" # Fallowfield Station
          "170 WALTER BAKER"
        end
      end
    end

    def route_171 (heading, stops)
      case stops.last[:code]
      when "3043" # Fallowfield Station
        "171 FALLOWFIELD"
      when "2354" # Golflinks Dr. & Jockvale Rd.
        "171 STONEBRIDGE"
      when "1388" # Market Place & Greenbank Rd.
        "171X BARRHAVEN CENTRE"
      end
    end

    def route_172 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "172 BAYSHORE"
      when "4086" # Greenbank Rd. & Iris St.
        "172X IRIS"
      when "1695" # Greenbank Rd. & Baseline Rd.
        "172X GREENBANK & BASELINE"
      when "3014" # Lincoln Fields Station
        "172 LINCOLN FIELDS"
      when "3023" # Hurdman Station
        "172X DOWNTOWN"
      when "3027" # Blair Station
        "172X BLAIR"
      end
    end

    def route_173 (heading, stops)
      case stops.last[:code]
      when "1249" # Greenbank Rd. & Strandherd Dr.
        "173 BARRHAVEN CENTRE"
      when "3043" # Fallowfield Station
        "173 FALLOWFIELD"
      end
    end

    def route_174 (heading, stops)
      case stops.last[:code]
      when "0524" # Carlingwood Mall
        "174 CARLINGWOOD"
      when "1717" # Greenbank Rd. & Gibbard Ave.
        "174X GREENBANK"
      end
    end

    def route_176 (heading, stops)
      case stops.last[:code]
      when "3043" # Fallowfield Station
        "176 NEPEAN SOUTH"
      when "6103" # Merivale Rd. & Slack Rd.
        "176X NEPEAN CENTRE"
      when "6104" # Merivale Rd. & Slack Rd.
        "176X NEPEAN CENTRE"
      when "3011" # Tunney’s Pasture Station
        "176 TUNNEY'S PASTURE"
      when "3010" # Lebreton Station
        "176X LEBRETON"
      when "3023" # Hurdman Station
        "176X DOWNTOWN"
      end
    end

    def route_178 (heading, stops)
      case stops.last[:code]
      when "3014" # Lincoln Fields Station
        "178 LINCOLN FIELDS"
      when "3023" # Hurdman Station
        "178X DOWNTOWN"
      end
    end

    def route_179 (heading, stops)
      case stops.last[:code]
      when "3014" # Lincoln Fields Station
        "179 LINCOLN FIELDS"
      when "0955" # 2 Haanel
        "179 NEPEAN CENTRE"
      end
    end

    def route_181 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "181 BAYSHORE"
      when "1388" # Market Place & Greenbank Rd.
        "181 NEPEAN SOUTH"
      end
    end

    def route_182 (heading, stops)
      case stops.last[:code]
      when "1382" # 301 Terry Fox Dr.
        "182 KANATA"
      when "3010" # Lebreton Station
        "182 LEBRETON"
      when "3023" # Hurdman Station
        "182X HURDMAN"
      end
    end

    def route_183 (heading, stops)
      case stops.last[:code]
      when "3058" # Terry Fox Station
        "183 KANATA"
      when "0576" # Palladium Dr. & Huntmar Rd.
        "183 LOCAL WEST"
      end
    end

    def route_184 (heading, stops)
      case stops.last[:code]
      when "0425" # Hope Side Rd. & Crownridge Dr.
        "184 HOPE SIDE"
      when "3058" # Terry Fox Station
        "184 TERRY FOX"
      end
    end

    def route_186 (heading, stops)
      case stops.last[:code]
      when "3043" # Fallowfield Station
        "186 FALLOWFIELD"
      when "8048" # Carlingwood Mall
        "186X CARLINGWOOD"
      when "1497" # Beaverwood Rd. & Ann St.
        "186 MANOTICK"
      when "3747" # Fourth Line & Andrew
        "186X NORTH GOWER"
      end
    end

    def route_187 (heading, stops)
      case stops.last[:code]
      when "7496" # 1805 Woodward Ave.
        "187 IRIS"
      when "3012" # Westboro Station
        "187 WESTBORO"
      end
    end

    def route_188 (heading, stops)
      case stops.last[:code]
      when "3014" # Lincoln Fields Station
        "188 LINCOLN FIELDS"
      when "0848" # Fallowfield Rd. & Barran St.
        "188 NEPEAN SOUTH"
      end
    end

    def route_190 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "190 HURDMAN"
      when "8738" # Montreal Rd. & Lang’s Rd.
        "190 OTTAWA ROCKCLIFFE"
      end
    end

    def route_191 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "191 HURDMAN"
      when "3337" # Russell Rd. & Hydro Dam Rd.
        "191 OTTAWA SOUTH"
      end
    end

    def route_192 (heading, stops)
      case stops.last[:code]
      when "0876" # 2380 Lancaster Rd.
        "192 ELMVALE"
      when "3023" # Hurdman Station
        "192 HURDMAN"
      end
    end

    def route_193 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "193 ORLEANS"
      end
    end

    def route_194 (heading, stops)
      case stops.last[:code]
      when "3027" # Blair Station
        "194 BLAIR"
      when "8449" # Canotek Rd. & Rainbow Crescent
        "194 GLOUCESTER NORTH"
      end
    end

    def route_197 (heading, stops)
      case stops.last[:code]
      when "1982" # 4550 Bank St.
        "197 GLOUCESTER SOUTH"
      when "1541" # Leitrim Rd. & Cfb Leitrim
        "197X CFB LEITRIM"
      when "3037" # Greenboro Station
        "197 SOUTH KEYS"
      end
    end

    def route_221 (heading, stops)
      case stops.last[:code]
      when "1460" # Old Montreal Rd. & Peter Harkness
        "221 CUMBERLAND"
      when "3010" # Lebreton Station
        "221 DOWNTOWN"
      end
    end

    def route_231 (heading, stops)
      case stops.last[:code]
      when "3721" # 3585 Sarsfield Rd.
        "231 CUMBERLAND"
      when "3010" # Lebreton Station
        "231 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "231X LINCOLN FIELDS"
      end
    end

    def route_232 (heading, stops)
      case stops.last[:code]
      when "2049" # Devine Rd. & Rockdale Rd.
        "232 CUMBERLAND"
      when "3010" # Lebreton Station
        "232 DOWNTOWN"
      when "3014" # Lincoln Fields Station
        "232X LINCOLN FIELDS"
      end
    end

    def route_261 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "261 DOWNTOWN"
      when "3027" # Blair Station
        "261X BLAIR"
      when "9068" # Stittsville Main St. & Bryce
        "261 GOULBOURN"
      end
    end

    def route_262 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "262 DOWNTOWN"
      when "3027" # Blair Station
        "262X BLAIR"
      when "0370" # Fernbank Rd. & Liard St.
        "262 GOULBOURN"
      end
    end

    def route_263 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "263 DOWNTOWN"
      when "6570" # Kimini Dr. & Fallowfield Rd.
        "263 GOULBOURN"
      end
    end

    def route_283 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "283 DOWNTOWN"
      when "3027" # Blair Station
        "283X BLAIR"
      when "6282" # McBean St. & Burke Rd.
        "283 GOULBOURN"
      when "2246" # Munster Side & Flewellyn Rd.
        "283X GOULBOURN MUNSTER"
      end
    end

    def route_306 (heading, stops)
      case stops.last[:code]
      when "0447" # Garry J Armstrong
        "306 ISLAND LODGE"
      when "7585" # Bruyère St. & Parent Ave.
        "306 ELISABETH BRUYÈRE"
      end
    end

    def route_316 (heading, stops)
      case stops.last[:code]
      when "3009" # Rideau Centre
        "316 DOWNTOWN"
      when "5892" # Wiggins Pvt. & Chapel Rd.
        "316 SANDY HILL"
      end
    end

    def route_601 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "601 HURDMAN"
      when "3658" # Bearbrook Rd. & Westpark Dr.
        "601 LOUIS RIEL HIGH SCHOOL"
      end
    end

    def route_602 (heading, stops)
      case stops.last[:code]
      when "6307" # Provence Ave. & Valin St.
        "602 MAPLE RIDGE SCHOOL"
      when "3375" # Lakeridge Dr. & Lakeridge Dr.
        "602 ORLEANS"
      end
    end

    def route_603 (heading, stops)
      case stops.last[:code]
      when "6828" # Old St. Patrick St. & Beausoleil Dr.
        "603 DE LA SALLE HIGH SCHOOL"
      when "3011" # Tunney’s Pasture Station
        "603 TUNNEY’S PASTURE"
      end
    end

    def route_604 (heading, stops)
      case stops.last[:code]
      when "3034" # Billings Bridge Station
        "604 BILLINGS BRIDGE"
      when "6828" # Old St. Patrick St. & Beausoleil Dr.
        "604 DE LA SALLE HIGH SCHOOL"
      end
    end

    def route_605 (heading, stops)
      case stops.last[:code]
      when "3037" # Greenboro Station
        "605 SOUTH KEYS"
      when "6828" # Old St. Patrick St. & Beausoleil Dr.
        "605 DE LA SALLE HIGH SCHOOL"
      end
    end
  
    def route_606 (heading, stops)
      case stops.last[:code]
      when "3375" # Lakeridge Dr. & Lakeridge Dr.
        "606 LAKERIDGE"
      when "7924" # Orléans Blvd. & St. Louis Dr.
        "606 CAIRINE WILSON SCHOOL"
      end
    end
  
    def route_607 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "607 ORLEANS"
      when "3328" # Millenium & E.S. Gisèle Lalonde
        "607 GISÈLE LALONDE HIGH SCHOOL"
      end
    end
  
    def route_608 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "608 ORLEANS"
      when "6828" # Old St. Patrick St. & Beausoleil Dr.
        "608 GISÈLE LALONDE HIGH SCHOOL"
      end
    end
  
    def route_609 (heading, stops)
      case stops.last[:code]
      when "4172" # Uplands Dr. & Paul Anka Dr.
        "609 OTTAWA SOUTH"
      end
    end
  
    def route_610 (heading, stops)
      case stops.last[:code]
      when "3328" # Millenium & E.S. Gisèle Lalonde
        "610 GISÈLE LALONDE HIGH SCHOOL"
      when "7813" # Beausejour Dr. & Orléans Blvd.
        "610 ORLEANS"
      end
    end
  
    def route_611 (heading, stops)
      case stops.last[:code]
      when "3328" # Millenium & E.S. Gisèle Lalonde
        "611 GISÈLE LALONDE HIGH SCHOOL"
      when "1737" # Youville Dr. & St. Joseph Blvd.
        "611 ORLEANS"
      end
    end
  
    def route_612 (heading, stops)
      case stops.last[:code]
      when "3328" # Millenium & E.S. Gisèle Lalonde
        "612 GISÈLE LALONDE HIGH SCHOOL"
      when "2453" # Orléans Blvd. & Innes Rd.
        "612 ORLEANS"
      end
    end
  
    def route_613 (heading, stops)
      case stops.last[:code]
      when "3000" # Mackenzie King Station
        "613 DOWNTOWN"
      end
    end
  
    def route_614 (heading, stops)
      case stops.last[:code]
      when "8698" # Ogilvie Rd. & Lester B. Pearson High School
        "614 LESTER B. PEARSON HIGH SCHOOL"
      when "2645" # Innes Rd. & Orléans Blvd.
        "614 ORLEANS"
      end
    end

    def route_615 (heading, stops)
      case stops.last[:code]
      when "2023" # Meadowbrook Rd. & Appleton Dr.
        "615 GLOUCESTER NORTH"
      when "8698" # Ogilvie Rd. & Lester B. Pearson High School
        "615 LESTER B. PEARSON HIGH SCHOOL"
      end
    end
  
    def route_616 (heading, stops)
      case stops.last[:code]
      when "3328" # Millenium & E.S. Gisèle Lalonde
        "616 GISÈLE LALONDE HIGH SCHOOL"
      when "3028" # Place d’Orléans Station
        "616 ORLEANS"
      end
    end
  
    def route_617 (heading, stops)
      case stops.last[:code]
      when "8698" # Ogilvie Rd. & Lester B. Pearson High School
        "617 LESTER B. PEARSON HIGH SCHOOL"
      when "2614" # Innes Rd. & Tauvette St.
        "617 INNES & TAUVETTE"
      end
    end
  
    def route_618 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "618 ORLEANS"
      when "2589" # Bearbrook Rd. & Westpark Dr.
        "618 LOUIS RIEL HIGH SCHOOL"
      end
    end

    def route_619 (heading, stops)
      case stops.last[:code]
      when "3027" # Blair Station
        "619 BLAIR"
      when "2589" # Bearbrook Rd. & Westpark Dr.
        "619 LOUIS RIEL HIGH SCHOOL"
      end
    end
  
    def route_620 (heading, stops)
      case stops.last[:code]
      when "6309" # Portobello Blvd. & Markwick Crescent
        "620 PORTOBELLO & MARKWICK"
      when "1674" # Charlemagne Blvd. & Merkley
        "620 ST. PETER’S HIGH SCHOOL"
      end
    end

    def route_621 (heading, stops)
      case stops.last[:code]
      when "0549" # Kender Ave. & Ogilvie Rd.
        "621 COLONEL BY HIGH SCHOOL"
      when "7761" # Viseneau Dr. & Innes Rd.
        "621 VISENEAU & INNES"
      end
    end
  
    def route_622 (heading, stops)
      case stops.last[:code]
      when "0549" # Kender Ave. & Ogilvie Rd.
        "622 COLONEL BY HIGH SCHOOL"
      when "2645" # Innes Rd. & Orléans Blvd.
        "622 ORLEANS"
      end
    end

    def route_623 (heading, stops)
      case stops.last[:code]
      when "0549" # Kender Ave. & Ogilvie Rd.
        "623 COLONEL BY HIGH SCHOOL"
      when "7767" # Innes Rd. & Jeanne d’Arc Blvd.
        "623 JEANNE D’ARC"
      end
    end

    def route_624 (heading, stops)
      case stops.last[:code]
      when "2576" # 2020 Ogilvie Rd.
        "624 GLOUCESTER HIGH SCHOOL"
      when "3309" # Navan Rd. & Blackburn Hamlet Bypass
        "624 ORLEANS"
      end
    end
  
    def route_625 (heading, stops)
      case stops.last[:code]
      when "0549" # Kender Ave. & Ogilvie Rd.
        "625 COLONEL BY HIGH SCHOOL"
      when "7866" # Charlemagne Blvd. & Tenth Line Rd.
        "625 ORLEANS"
      end
    end
  
    def route_626 (heading, stops)
      case stops.last[:code]
      when "0549" # Kender Ave. & Ogilvie Rd.
        "626 COLONEL BY HIGH SCHOOL"
      when "7767" # Innes Rd. & Jeanne d’Arc Blvd.
        "626 ORLEANS"
      end
    end
  
    def route_627 (heading, stops)
      case stops.last[:code]
      when "0549" # Kender Ave. & Ogilvie Rd.
        "627 COLONEL BY HIGH SCHOOL"
      when "3028" # Place d’Orléans Station
        "627 ORLEANS"
      end
    end
  
    def route_628 (heading, stops)
      case stops.last[:code]
      when "8667" # Ogilvie Rd. & Jasmine Crescent
        "628 GLOUCESTER HIGH SCHOOL"
      when "2479" # Meadowglen Dr. & Orléans Blvd.
        "628 ORLEANS"
      end
    end
  
    def route_629 (heading, stops)
      case stops.last[:code]
      when "8667" # Ogilvie Rd. & Jasmine Crescent
        "629 GLOUCESTER HIGH SCHOOL"
      when "2614" # Innes Rd. & Tauvette St.
        "629 INNES & TAUVETTE"
      end
    end
  
    def route_630 (heading, stops)
      case stops.last[:code]
      when "1831" # Jeanne d’Arc Blvd. & St. Joseph Blvd.
        "630 ORLEANS"
      when "3328" # Millenium & E.S. Gisèle Lalonde
        "630 GISÈLE LALONDE HIGH SCHOOL"
      end
    end

    def route_631 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "631 ORLEANS"
      when "0541" # Carriere St. & é.S. Garneau
        "631 GARNEAU HIGH SCHOOL"
      end
    end

    def route_632 (heading, stops)
      case stops.last[:code]
      when "7803" # St. Joseph Blvd. & Cousineau St.
        "632 ORLEANS"
      when "3328" # Millenium & E.S. Gisèle Lalonde
        "632 GISÈLE LALONDE HIGH SCHOOL"
      end
    end
  
    def route_633 (heading, stops)
      case stops.last[:code]
      when "8698" # Ogilvie Rd. & Lester B. Pearson High School
        "633 LESTER B. PEARSON HIGH SCHOOL"
      when "3025" # St. Laurent Station
        "633 ST. LAURENT"
      end
    end

    def route_634 (heading, stops)
      case stops.last[:code]
      when "8166" # Jeanne d’Arc Blvd. & Orléans Blvd.
        "634 ORLEANS"
      when "0541" # Carriere St. & é.S. Garneau
        "634 GARNEAU HIGH SCHOOL"
      end
    end

    def route_635 (heading, stops)
      case stops.last[:code]
      when "8667" # Ogilvie Rd. & Jasmine Crescent
        "635 GLOUCESTER HIGH SCHOOL"
      when "1761" # Jeanne d’Arc Blvd. & Des Épinettes Ave.
        "635 ORLEANS"
      end
    end

    def route_636 (heading, stops)
      case stops.last[:code]
      when "0547" # Provence Ave. & Innes Rd.
        "636 BEATRICE DES LOGES HIGH SCHOOL"
      when "1737" # Youville Dr. & St. Joseph Blvd.
        "636 CHAPEL HILL"
      end
    end

    def route_637 (heading, stops)
      case stops.last[:code]
      when "7955" # Des Épinettes Ave. & Duvergne
        "637 ORLEANS"
      when "1674" # Charlemagne Blvd. & Merkley
        "637 ST. PETER’S HIGH SCHOOL"
      end
    end

    def route_638 (heading, stops)
      case stops.last[:code]
      when "2453" # Orléans Blvd. & Innes Rd.
        "638 ORLEANS"
      when "0541" # Carriere St. & é.S. Garneau
        "638 GARNEAU HIGH SCHOOL"
      end
    end

    def route_639 (heading, stops)
      case stops.last[:code]
      when "8471" # Southgate Rd. & Clearwater Crescent
        "639 OTTAWA SOUTH"
      when "8359" # Alta Vista Dr. & Heron Rd.
        "639 ST. PATRICK’S HIGH SCHOOL"
      end
    end
  
    def route_640 (heading, stops)
      case stops.last[:code]
      when "4137" # Flannery Dr. & Brookfield Rd.
        "640 BROOKFIELD HIGH SCHOOL"
      when "3037" # Greenboro Station
        "640 GREENBORO"
      end
    end
  
    def route_641 (heading, stops)
      case stops.last[:code]
      when "1738" # Meadowglen Dr. & Orléans Blvd.
        "641 ORLEANS"
      when "2591" # Bearbrook Rd. & Hornet’s Nest Park
        "641 LOUIS RIEL HIGH SCHOOL"
      end
    end
  
    def route_642 (heading, stops)
      case stops.last[:code]
      when "8885" # Rosebella Ave. & Sixth St.
        "642 BLOSSOM PARK"
      when "4022" # Merivale Rd. & Viewmount Dr.
        "642 MERIVALE HIGH SCHOOL"
      end
    end

    def route_643 (heading, stops)
      case stops.last[:code]
      when "3375" # Lakeridge Dr. & Lakeridge Dr.
        "643 ORLEANS"
      when "3328" # Millenium & E.S. Gisèle Lalonde
        "643 GISÈLE LALONDE HIGH SCHOOL"
      end
    end

    def route_644 (heading, stops)
      case stops.last[:code]
      when "8667" # Ogilvie Rd. & Jasmine Crescent
        "644 GLOUCESTER HIGH SCHOOL"
      when "1738" # Meadowglen Dr. & Orléans Blvd.
        "644 ORLEANS"
      end
    end

    def route_645 (heading, stops)
      case stops.last[:code]
      when "8667" # Ogilvie Rd. & Jasmine Crescent
        "645 GLOUCESTER HIGH SCHOOL"
      when "7866" # Charlemagne Blvd. & Tenth Line Rd.
        "645 ORLEANS"
      end
    end

    def route_646 (heading, stops)
      case stops.last[:code]
      when "8885" # Rosebella Ave. & Sixth St.
        "646 GLOUCESTER SOUTH"
      when "7185" # Alta Vista Dr. & Ayers Ave.
        "646 RIDGEMONT HIGH SCHOOL"
      end
    end

    def route_647 (heading, stops)
      case stops.last[:code]
      when "3037" # Greenboro Station
        "647 SOUTH KEYS"
      when "6001" # Chesterton Dr. & Viewmount Dr.
        "647 DESLAURIERS HIGH SCHOOL"
      end
    end

    def route_648 (heading, stops)
      case stops.last[:code]
      when "1737" # Youville Dr. & St. Joseph Blvd.
        "648 ORLEANS"
      when "2591" # Bearbrook Rd. & Hornet’s Nest Park
        "648 LOUIS RIEL HIGH SCHOOL"
      end
    end

    def route_649 (heading, stops)
      case stops.last[:code]
      when "3036" # Walkley Station
        "649 RIVERSIDE"
      when "8359" # Alta Vista Dr. & Heron Rd.
        "649 ST. PATRICK’S HIGH SCHOOL"
      end
    end

    def route_650 (heading, stops)
      case stops.last[:code]
      when "8454" # Riverside Dr. & Rivergate Way
        "650 RIVERSIDE"
      when "8359" # Alta Vista Dr. & Heron Rd.
        "650 ST. PATRICK’S HIGH SCHOOL"
      end
    end

    def route_651 (heading, stops)
      case stops.last[:code]
      when "8345" # Canterbury Ave. & Plesser St.
        "651 CANTERBURY HIGH SCHOOL"
      when "3037" # Greenboro Station
        "651 SOUTH KEYS"
      end
    end

    def route_652 (heading, stops)
      if stops.last[:stop_id] == "NO451" # Dauphin Rd. & Hillcrest High School
        "652 HILLCREST HIGH SCHOOL"
      else
        case stops.last[:code]
        when "3037" # Greenboro Station
          "652 SOUTH KEYS"
        end
      end
    end
  
    def route_653 (heading, stops)
      case stops.last[:code]
      when "8566" # Haig Dr. & Quinlan Rd.
        "653 ELMVALE"
      when "8359" # Alta Vista Dr. & Heron Rd.
        "653 ST. PATRICK’S HIGH SCHOOL"
      end
    end

    def route_654 (heading, stops)
      case stops.last[:code]
      when "3330" # Conroy Rd. & Johnston Rd.
        "654 LORRY GREENBERG"
      when "8359" # Alta Vista Dr. & Heron Rd.
        "654 ST. PATRICK’S HIGH SCHOOL"
      end
    end

    def route_655 (heading, stops)
      case stops.last[:code]
      when "4236" # Albion Rd. & Cahill Dr.
        "655 SOUTH KEYS"
      when "8359" # Alta Vista Dr. & Heron Rd.
        "655 ST. PATRICK’S HIGH SCHOOL"
      end
    end

    def route_656 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "656 HURDMAN"
      when "6001" # Chesterton Dr. & Viewmount Dr.
        "656 DESLAURIERS HIGH SCHOOL"
      end
    end

    def route_657 (heading, stops)
      case stops.last[:code]
      when "3017" # Baseline Station
        "657 BASELINE"
      when "6723" # Fisher Ave. & Dynes Rd.
        "657 ST. PIUS HIGH SCHOOL"
      end
    end

    def route_658 (heading, stops)
      case stops.last[:code]
      when "0521" # Parkway Rd. & Earl Of March H.S.
        "658 EARL OF MARCH HIGH SCHOOL"
      when "4842" # Eagleson Rd. & Hazeldean Mall
        "658 GLEN CAIRN"
      end
    end

    def route_659 (heading, stops)
      case stops.last[:code]
      when "6234" # Harness Ln. & Stonehaven Dr.
        "659 BRIDLEWOOD"
      when "0521" # Parkway Rd. & Earl Of March H.S.
        "659 EARL OF MARCH HIGH SCHOOL"
      end
    end

    def route_660 (heading, stops)
      case stops.last[:code]
      when "5305" # é.S. Bell H.S.
        "660 BELL HIGH SCHOOL"
      when "6155" # Terry Fox Dr. & March Rd.
        "660 KANATA"
      end
    end

    def route_661 (heading, stops)
      case stops.last[:code]
      when "5305" # é.S. Bell H.S.
        "661 BELL HIGH SCHOOL"
      when "5380" # Kanata Ave. & Goldridge Dr.
        "661 KANATA"
      end
    end

    def route_662 (heading, stops)
      case stops.last[:code]
      when "0572" # Abbeyhill Dr. & A.Y. Jackson H.S.
        "662 A.Y. JACKSON HIGH SCHOOL"
      when "0425" # Hope Side Rd. & Crownridge Dr.
        "662 BRIDLEWOOD"
      end
    end

    def route_663 (heading, stops)
      case stops.last[:code]
      when "0572" # Abbeyhill Dr. & A.Y. Jackson H.S.
        "663 A.Y. JACKSON HIGH SCHOOL"
      when "6216" # Stonehaven Dr. & Steeplechase
        "663 BRIDLEWOOD"
      end
    end

    def route_664 (heading, stops)
      case stops.last[:code]
      when "3014" # Lincoln Fields Station
        "664 LINCOLN FIELDS"
      when "6001" # Chesterton Dr. & Viewmount Dr.
        "664 DESLAURIERS HIGH SCHOOL"
      end
    end

    def route_665 (heading, stops)
      case stops.last[:code]
      when "5305" # é.S. Bell H.S.
        "665 BELL HIGH SCHOOL"
      when "0425" # Hope Side Rd. & Crownridge Dr.
        "665 BRIDLEWOOD"
      end
    end

    def route_667 (heading, stops)
      case stops.last[:code]
      when "5305" # é.S. Bell H.S.
        "667 BELL HIGH SCHOOL"
      when "5326" # Grandview Rd. & Borden
        "667 GRANDVIEW"
      end
    end

    def route_668 (heading, stops)
      case stops.last[:code]
      when "3017" # Baseline Station
        "668 BASELINE"
      end
    end

    def route_669 (heading, stops)
      case stops.last[:code]
      when "6786" # Bayshore Dr. & Carling Ave.
        "669 BAYSHORE"
      when "5305" # é.S. Bell H.S.
        "669 BELL HIGH SCHOOL"
      end
    end

    def route_670 (heading, stops)
      case stops.last[:code]
      when "4471" # Vaan Dr. & Coleway
        "670 NEPEAN SOUTH"
      when "6723" # Fisher Ave. & Dynes Rd.
        "670 ST. PIUS HIGH SCHOOL"
      end
    end

    def route_671 (heading, stops)
      case stops.last[:code]
      when "7924" # Orléans Blvd. & St. Louis Dr.
        "671 CAIRINE WILSON SCHOOL"
      when "7866" # Charlemagne Blvd. & Tenth Line Rd.
        "671 ORLEANS"
      end
    end

    def route_672 (heading, stops)
      case stops.last[:code]
      when "0892" # Lorry Greenberg Dr. & Bramblegrove Crescent
        "672 LOCAL EAST"
      when "7185" # Alta Vista Dr. & Ayers Ave.
        "672 RIDGEMONT HIGH SCHOOL"
      end
    end

    def route_673 (heading, stops)
      case stops.last[:code]
      when "0521" # Parkway Rd. & Earl Of March H.S.
        "673 EARL OF MARCH HIGH SCHOOL"
      when "3058" # Terry Fox Station
        "673 KANATA"
      end
    end

    def route_674 (heading, stops)
      case stops.last[:code]
      when "3579" # Kanata Ave. & Walden Dr.
        "674 ALL SAINTS HIGH SCHOOL"
      when "5785" # Terry Fox Dr. & McKinley Dr.
        "674 KANATA"
      end
    end

    def route_675 (heading, stops)
      case stops.last[:code]
      when "4978" # Tartan Dr. & Townsend Dr.
        "675 BARRHAVEN"
      when "4022" # Merivale Rd. & Viewmount Dr.
        "675 MERIVALE HIGH SCHOOL"
      end
    end

    def route_677 (heading, stops)
      case stops.last[:code]
      when "4022" # Merivale Rd. & Viewmount Dr.
        "677 MERIVALE HIGH SCHOOL"
      when "3345" # Beatrice Dr. & Queensbury Dr.
        "677 QUEENSBURY"
      end
    end

    def route_678 (heading, stops)
      case stops.last[:code]
      when "2589" # Bearbrook Rd. & Westpark Dr.
        "678 LOUIS RIEL HIGH SCHOOL"
      when "1741" # Jeanne d’Arc Blvd. & Regional Road 174
        "678 ORLEANS"
      end
    end
  
    def route_679 (heading, stops)
      case stops.last[:code]
      when "5471" # Jockvale Rd. & Jennifer Ln.
        "679 BARRHAVEN"
      when "5452" # 2760 Cedarview Rd.
        "679 CEDARVIEW SCHOOL"
      end
    end
  
    def route_680 (heading, stops)
      case stops.last[:code]
      when "5305" # é.S. Bell H.S.
        "680 BELL HIGH SCHOOL"
      when "6184" # Castlefrank Rd. & McCurdy Dr.
        "680 KATIMAVIK"
      end
    end
  
    def route_681 (heading, stops)
      case stops.last[:code]
      when "5304" # Bell High School & Cassidy Rd.
        "681 BELL HIGH SCHOOL"
      when "6166" # Hazeldean Rd. & Carbrooke St.
        "681 GLEN CAIRN"
      end
    end
  
    def route_683 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "683 BAYSHORE"
      end
    end
  
    def route_684 (heading, stops)
      case stops.last[:code]
      when "2391" # Carling Ave. & Holland Ave.
        "684 OTTAWA WEST"
      end
    end
  
    def route_687 (heading, stops)
      case stops.last[:code]
      when "4022" # Merivale Rd. & Viewmount Dr.
        "687 MERIVALE HIGH SCHOOL"
      when "0328" # Longfields Dr. & Portrush Ave.
        "687 STRANDHERD"
      end
    end
  
    def route_688 (heading, stops)
      case stops.last[:code]
      when "3017" # Baseline Station
        "688 BASELINE"
      end
    end
  
    def route_690 (heading, stops)
      case stops.last[:code]
      when "3017" # Baseline Station
        "690 BASELINE"
      when "6723" # Fisher Ave. & Dynes Rd.
        "690 ST. PIUS HIGH SCHOOL"
      end
    end
  
    def route_691 (heading, stops)
      case stops.last[:code]
      when "3050" # Bayshore Station
        "691 BAYSHORE"
      when "6001" # Chesterton Dr. & Viewmount Dr.
        "691 DESLAURIERS HIGH SCHOOL"
      end
    end

    def route_692 (heading, stops)
      if stops.last[:stop_id] == "NO451" # Dauphin Rd. & Hillcrest High School
        "692 HILLCREST HIGH SCHOOL"
      else
        case stops.last[:code]
        when "4360" # Johnston Rd. & Langstrom Crescent
          "692 LORRY GREENBERG"
        end
      end
    end
  
    def route_693 (heading, stops)
      case stops.last[:code]
      when "3014" # Lincoln Fields Station
        "693 LINCOLN FIELDS"
      when "6828" # Old St. Patrick St. & Beausoleil Dr.
        "693 DE LA SALLE HIGH SCHOOL"
      end
    end
  
    def route_694 (heading, stops)
      case stops.last[:code]
      when "3027" # Blair Station
        "694 BLAIR"
      when "6828" # Old St. Patrick St. & Beausoleil Dr.
        "694 DE LA SALLE HIGH SCHOOL"
      end
    end
  
    def route_695 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "695 ORLEANS"
      when "0547" # Provence Ave. & Innes Rd.
        "695 BEATRICE DES LOGES SCHOOL"
      end
    end
  
    def route_696 (heading, stops)
      case stops.last[:code]
      when "0539" # Cedarview Middle School
        "696 CEDARVIEW SCHOOL"
      when "4978" # Tartan Dr. & Townsend Dr.
        "696 LOCAL SOUTH"
      end
    end
  
    def route_750 (heading, stops)
      case stops.last[:code]
      when "3060" # Bayview Station
        "750 BAYVIEW"
      when "3037" # Greenboro Station
        "750 GREENBORO"
      end
    end

    def route_824 (heading, stops)
      case stops.last[:code]
      when "7136" # Belfast Rd. & St. Laurent Blvd.
        "824 ST. LAURENT"
      end
    end

    def route_825 (heading, stops)
      case stops.last[:code]
      when "3023" # Hurdman Station
        "825 HURDMAN"
      end
    end

    def route_829 (heading, stops)
      case stops.last[:code]
      when "1091" # St. Laurent Blvd. & Tremblay Rd.
        "829 DOWNTOWN"
      end
    end

    def route_830 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "830 ORLEANS LOCAL"
      end
    end

    def route_835 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "835 ORLEANS"
      end
    end

    def route_837 (heading, stops)
      case stops.last[:code]
      when "3028" # Place d’Orléans Station
        "837 ORLEANS"
      end
    end

    def route_891 (heading, stops)
      if stops.last[:stop_id] == "NO341" # Colonnade Rd. & OC Transpo Garage
        "891X NEPEAN CENTRE"
      else
        case stops.last[:code]
        when "2395" # 2550 Queensview Dr.
          "891 PINECREST"
        when "3025" # St. Laurent Station
          "891 ST. LAURENT"
        end
      end
    end
  end
end