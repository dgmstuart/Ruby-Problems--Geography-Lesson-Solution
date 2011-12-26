class LatLong
 
  Decimal = "[0-9]*\.?[0-9]+"
  Integer ="[0-9]*"
  
  Sign = "[-+]?"
  Direction = "[NSEW]"
  
 
  def to_xy(input)
    @input = input
    
    matches = /^(#{Decimal}) (#{Direction}) (#{Decimal}) (#{Direction})$/.match(@input)
    unless matches.nil?
      y_degrees, y_sign, x_degrees, x_sign = matches[1,4]
    else
      matches = /^(#{Sign})(#{Decimal}) (#{Sign})(#{Decimal})$/.match(@input)
      matches = /^(#{Direction}) (#{Decimal}) (#{Direction}) (#{Decimal})$/.match(@input) if matches.nil?
      unless matches.nil?
        y_sign, y_degrees, x_sign, x_degrees  = matches[1,4]
      else
        matches = /^(#{Integer}) (#{Decimal}) (#{Direction}) (#{Integer}) (#{Decimal}) (#{Direction})$/.match(@input)
        unless matches.nil?
          y_degrees, y_minutes, y_sign, x_degrees, x_minutes, x_sign = matches[1,6]
        else  
          matches = /^(#{Direction}) (#{Integer}) (#{Decimal}) (#{Direction}) (#{Integer}) (#{Decimal})$/.match(@input)
          matches = /^(#{Sign})(#{Integer}) (#{Decimal}) (#{Sign})(#{Integer}) (#{Decimal})$/.match(@input) if matches.nil?
          unless matches.nil?
            y_sign, y_degrees, y_minutes, x_sign, x_degrees, x_minutes = matches[1,6]
          else
            matches = /^(#{Integer}) (#{Integer}) (#{Decimal}) (#{Direction}) (#{Integer}) (#{Integer}) (#{Decimal}) (#{Direction})$/.match(@input)
            unless matches.nil?
              y_degrees, y_minutes, y_seconds, y_sign, x_degrees, x_minutes, x_seconds, x_sign = matches[1,8]
            else  
              matches = /^(#{Direction}) (#{Integer}) (#{Integer}) (#{Decimal}) (#{Direction}) (#{Integer}) (#{Integer}) (#{Decimal})$/.match(@input)
              matches = /^(#{Sign})(#{Integer}) (#{Integer}) (#{Decimal}) (#{Sign})(#{Integer}) (#{Integer}) (#{Decimal})$/.match(@input) if matches.nil?
              unless matches.nil?
                y_sign, y_degrees, y_minutes, y_seconds, x_sign, x_degrees, x_minutes, x_seconds = matches[1,8]
              else
                return #no match
              end
            end
          end
        end
      end
    end
    
    get_coords_from_degrees_minutes_and_seconds(x_degrees, y_degrees, x_minutes, y_minutes, x_seconds, y_seconds)
    
    # North and East are positive in Cartesian space, West and South are negative  
    @y = 0-@y if y_sign == "-" or y_sign == "S" 
    @x = 0-@x if x_sign == "-" or x_sign == "W"
    
    [@x, @y]
  end
  
  def get_coords_from_degrees_minutes_and_seconds(x_degrees, y_degrees, x_minutes=0, y_minutes=0, x_seconds=0, y_seconds=0)
    @y = y_degrees.to_f + y_minutes.to_f/60 + y_seconds.to_f/3600
    @x = x_degrees.to_f + x_minutes.to_f/60 + x_seconds.to_f/3600
  end

end