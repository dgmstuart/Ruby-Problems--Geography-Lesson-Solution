class LatLong
 
  UnsignedDecimal = "[0-9]*\.?[0-9]+"
  UnsignedInteger ="[0-9]*"
  
  Sign = "[-+]?"
  Direction = "[NSEW]"
  
  Decimal = Sign + UnsignedDecimal
 
  def to_xy(input)
    @input = input
    result = decimal_degrees
    result = decimal_degrees_minutes if result.nil?
    result = decimal_degrees_minutes_seconds if result.nil?
    
    sign_coordinates
  end
  
  def decimal_degrees
    matches = /^(#{UnsignedDecimal}) (#{Direction}) (#{UnsignedDecimal}) (#{Direction})$/.match(@input)
    unless matches.nil?
      y, @y_sign, x, @x_sign = matches[1,4]
    else
      matches = /^(#{Sign})(#{UnsignedDecimal}) (#{Sign})(#{UnsignedDecimal})$/.match(@input)
      matches = /^(#{Direction}) (#{UnsignedDecimal}) (#{Direction}) (#{UnsignedDecimal})$/.match(@input) if matches.nil?
      unless matches.nil?
        @y_sign, y, @x_sign, x  = matches[1,4]
      else
        return #no match
      end
    end
    
    @x=x.to_f
    @y=y.to_f
  end
  
  def decimal_degrees_minutes
    matches = /^(#{UnsignedInteger}) (#{UnsignedDecimal}) (#{Direction}) (#{UnsignedInteger}) (#{UnsignedDecimal}) (#{Direction})$/.match(@input)
    unless matches.nil?
      y_degrees, y_minutes, @y_sign, x_degrees, x_minutes, @x_sign = matches[1,6]
    else  
      matches = /^(#{Direction}) (#{UnsignedInteger}) (#{UnsignedDecimal}) (#{Direction}) (#{UnsignedInteger}) (#{UnsignedDecimal})$/.match(@input)
      matches = /^(#{Sign})(#{UnsignedInteger}) (#{UnsignedDecimal}) (#{Sign})(#{UnsignedInteger}) (#{UnsignedDecimal})$/.match(@input) if matches.nil?
      unless matches.nil?
        @y_sign, y_degrees, y_minutes, @x_sign, x_degrees, x_minutes = matches[1,6]
      else
        return #no match
      end
    end
    
    get_coords_from_degrees_minutes_and_seconds(x_degrees, y_degrees, x_minutes, y_minutes)
  end
  
  def decimal_degrees_minutes_seconds
    matches = /^(#{UnsignedInteger}) (#{UnsignedInteger}) (#{UnsignedDecimal}) (#{Direction}) (#{UnsignedInteger}) (#{UnsignedInteger}) (#{UnsignedDecimal}) (#{Direction})$/.match(@input)
    unless matches.nil?
      y_degrees, y_minutes, y_seconds, @y_sign, x_degrees, x_minutes, x_seconds, @x_sign = matches[1,8]
    else  
      matches = /^(#{Direction}) (#{UnsignedInteger}) (#{UnsignedInteger}) (#{UnsignedDecimal}) (#{Direction}) (#{UnsignedInteger}) (#{UnsignedInteger}) (#{UnsignedDecimal})$/.match(@input)
      matches = /^(#{Sign})(#{UnsignedInteger}) (#{UnsignedInteger}) (#{UnsignedDecimal}) (#{Sign})(#{UnsignedInteger}) (#{UnsignedInteger}) (#{UnsignedDecimal})$/.match(@input) if matches.nil?
      unless matches.nil?
        @y_sign, y_degrees, y_minutes, y_seconds, @x_sign, x_degrees, x_minutes, x_seconds = matches[1,8]
      else
        return #no match
      end
    end
    
    get_coords_from_degrees_minutes_and_seconds(x_degrees, y_degrees, x_minutes, y_minutes, x_seconds, y_seconds)
  end
  
  def get_coords_from_degrees_minutes_and_seconds(x_degrees, y_degrees, x_minutes, y_minutes, x_seconds=0, y_seconds=0)
    @y = y_degrees.to_i + y_minutes.to_f/60 + y_seconds.to_f/3600
    @x = x_degrees.to_i + x_minutes.to_f/60 + x_seconds.to_f/3600
  end

  # Modify coordinates which are negative
  def sign_coordinates
    # North and East are positive in Cartesian space, West and South are negative  
    @y = 0-@y if @y_sign == "-" or @y_sign == "S" 
    @x = 0-@x if @x_sign == "-" or @x_sign == "W" 
    
    [@x, @y]
  end
end