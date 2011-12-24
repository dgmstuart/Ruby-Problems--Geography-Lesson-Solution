class LatLong
 
  UnsignedDecimal = "[0-9]*\.?[0-9]+"
  Decimal = "[-+]?" + UnsignedDecimal
  Integer ="[0-9]"
  
  Direction = "[NSEW]"
 
 
 
  def to_xy(input)
    @input = input
    result = signed_decimal_degrees
    result = decimal_degrees_directions if result.nil? 
    return result
  end
  
  def signed_decimal_degrees
    matches = /^(#{Decimal}) (#{Decimal})$/.match(@input)
    unless matches.nil?
      y = matches[1].to_f
      x = matches[2].to_f
      return [x, y]
    end
  end
  
  def decimal_degrees_directions
    matches = /^(#{UnsignedDecimal}) (#{Direction}) (#{UnsignedDecimal}) (#{Direction})$/.match(@input)
    unless matches.nil?
      y, ns, x, ew = matches[1,4]
    else
      matches = /^(#{Direction}) (#{UnsignedDecimal}) (#{Direction}) (#{UnsignedDecimal})$/.match(@input)
      unless matches.nil?
        ns, y, ew, x = matches[1,4]
      else
        return #no match
      end
    end   
    # North and East are positive in Cartesian space, West and South are negative  
    y = y.to_f
    y = 0-y if ns == "S"
    x = x.to_f
    x = 0-x if ew == "W"
    return [x, y]
  end
  
  def decimal_degrees_minutes_directions
    matches = /^(#{Integer}) (#{UnsignedDecimal}) (#{Direction}) #{Integer}) (#{UnsignedDecimal}) (#{Direction})$/.match(@input)
    unless matches.nil?
      y_degrees, y_minutes, ns, x_degrees, x_minutes, ew = matches[1,6]
      
      y = y_degrees.to_i + y_minutes.to_f/60
      
      
  end

end