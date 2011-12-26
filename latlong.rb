class LatLong
 
  Decimal = "[0-9]*\.?[0-9]+"
  Integer ="[0-9]*"
  
  def method_missing(meth)
    method_name = meth.id2name
    if method_name =~ /^([xy])_degrees$/
      "(?<#{$1}_degrees>#{Decimal})"
    elsif method_name =~ /^([xy])_degrees_minutes$/
      "(?<#{$1}_degrees>#{Integer}) (?<#{$1}_minutes>#{Decimal})" 
    elsif method_name =~ /^([xy])_degrees_minutes_seconds$/
      "(?<#{$1}_degrees>#{Integer}) (?<#{$1}_minutes>#{Integer}) (?<#{$1}_seconds>#{Decimal})"
    elsif method_name =~ /^([xy])_sign$/
      "(?<#{$1}_sign>[-+]?)"
    elsif method_name =~ /^([xy])_direction$/
      "(?<#{$1}_sign>[NSEW])"
    else
      raise NoMethodError, "undefined method `#{method_name}' for #{self}:#{self.class}"
    end
  end
  
  def to_xy(input)
    y=0
    x=0
    
    matches = /^#{y_degrees_minutes_seconds} #{y_direction} #{x_degrees_minutes_seconds} #{x_direction}$/.match(input)
    matches = /^#{y_direction} #{y_degrees_minutes_seconds} #{x_direction} #{x_degrees_minutes_seconds}$/.match(input) if matches.nil?
    matches = /^#{y_sign}#{y_degrees_minutes_seconds} #{x_sign}#{x_degrees_minutes_seconds}$/.match(input) if matches.nil?
    
    y += matches[:y_seconds].to_f/3600 unless matches.nil?
    x += matches[:x_seconds].to_f/3600 unless matches.nil?
    
    matches = /^#{y_degrees_minutes} #{y_direction} #{x_degrees_minutes} #{x_direction}$/.match(input) if matches.nil?
    matches = /^#{y_direction} #{y_degrees_minutes} #{x_direction} #{x_degrees_minutes}$/.match(input) if matches.nil?
    matches = /^#{y_sign}#{y_degrees_minutes} #{x_sign}#{x_degrees_minutes}$/.match(input) if matches.nil?
    
    y += matches[:y_minutes].to_f/60 unless matches.nil?
    x += matches[:x_minutes].to_f/60 unless matches.nil?
    
    matches = /^#{y_degrees} #{y_direction} #{x_degrees} #{x_direction}$/.match(input) if matches.nil?
    matches = /^#{y_direction} #{y_degrees} #{x_direction} #{x_degrees}$/.match(input) if matches.nil?
    matches = /^#{y_sign}#{y_degrees} #{x_sign}#{x_degrees}$/.match(input) if matches.nil?
    
    return if matches.nil?

    y += matches[:y_degrees].to_f
    x += matches[:x_degrees].to_f
    
    # North and East are positive in Cartesian space, West and South are negative  
    y = 0-y if matches[:y_sign] == "-" or matches[:y_sign] == "S" 
    x = 0-x if matches[:x_sign] == "-" or matches[:x_sign] == "W"

    [x, y]
  end
end