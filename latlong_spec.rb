require './latlong'

describe LatLong do
  latlong = LatLong.new
  
  describe "#to_xy with Signed Decimal Degress" do
    it "correctly parses '45.1234 36.2345'" do
      latlong.to_xy("45.1234 36.2345").should == [36.2345,45.1234] 
    end
    it "correctly parses '+45.1234 +36.2345'" do
      latlong.to_xy("+45.1234 +36.2345").should == [36.2345,45.1234] 
    end
    it "correctly parses '-45.1234 -36.2345'" do
      latlong.to_xy("-45.1234 -36.2345").should == [-36.2345,-45.1234]
    end
    it "correctly parses '45.1234 -36.2345'" do
      latlong.to_xy("45.1234 -36.2345").should == [-36.2345,45.1234]
    end
    it "correctly parses '-45.1234 36.2345'" do
      latlong.to_xy("-45.1234 36.2345").should == [36.2345,-45.1234]
    end
  end
  
  describe "#to_xy with Decimal Degrees with Directions (Directions after Numbers)" do
    it "correctly parses '45.1234 N 36.2345 E'" do
      latlong.to_xy("45.1234 N 36.2345 E").should == [36.2345,45.1234]
    end
    it "correctly parses '45.1234 S 36.2345 W'" do
      latlong.to_xy("45.1234 S 36.2345 W").should == [-36.2345,-45.1234] 
    end
    it "correctly parses '45.1234 N 36.2345 W'" do
      latlong.to_xy("45.1234 N 36.2345 W").should == [-36.2345,45.1234]
    end
    it "correctly parses '45.1234 S 36.2345 E'" do
      latlong.to_xy("45.1234 S 36.2345 E").should == [36.2345,-45.1234]
    end
  end
  
  describe "#to_xy with Decimal Degrees with Directions (Numbers after Directions)" do   
    it "correctly parses 'N 45.1234 E 36.2345'" do
      latlong.to_xy("N 45.1234 E 36.2345").should == [36.2345,45.1234]
    end
    it "correctly parses 'S 45.1234 W 36.2345'" do
      latlong.to_xy("S 45.1234 W 36.2345").should == [-36.2345,-45.1234] 
    end
    it "correctly parses 'N 45.1234 W 36.2345'" do
      latlong.to_xy("N 45.1234 W 36.2345").should == [-36.2345,45.1234]
    end
    it "correctly parses 'S 45.1234 E 36.2345'" do
      latlong.to_xy("S 45.1234 E 36.2345").should == [36.2345,-45.1234]
    end
  end  
  
  describe "#to_xy with Decimal Degrees and Minutes and Directions" do   
    it "correctly parses '40 30.6 N 65 36.36 E'" do
      latlong.to_xy("40 30.6 N 65 36.36 E").should == [65.606,40.51]
    end
    # it "correctly parses '40 30.6 S 65 36.36 W'" do
    #       latlong.to_xy("40 30.6 S 65 36.36 W").should == [-65.606,-40.51] 
    #     end
    #     it "correctly parses '40 30.6 N 65 36.36 W'" do
    #       latlong.to_xy("40 30.6 N 65 36.36 W").should == [-65.606,40.51]
    #     end
    #     it "correctly parses 'N 40 30.6 E 65 36.36'" do
    #       latlong.to_xy("N 40 30.6 E 65 36.36").should == [65.606,40.51]
    #     end
    #     it "correctly parses 'S 40 30.6 W 65 36.36'" do
    #       latlong.to_xy("S 40 30.6 W 65 36.36").should == [-65.606,-40.51]
    #     end
    #     it "correctly parses 'N 40 30.6 W 65 36.36'" do
    #       latlong.to_xy("N 40 30.6 W 65 36.36").should == [-65.606,40.51]
    #     end
  end
  
  # describe "#to_xy with Signed Decimal Degrees and Minutes" do   
  #     it "correctly parses '40 30.6 65 36.36'" do
  #       latlong.to_xy("40 30.6 65 36.36").should == [65.606,40.51]
  #     end
  #     it "correctly parses '+40 30.6 +65 36.36'" do
  #       latlong.to_xy("+40 30.6 +65 36.36").should == [-65.606,-40.51] 
  #     end
  #     it "correctly parses '-40 30.6 -65 36.36'" do
  #       latlong.to_xy("-40 30.6 -65 36.36").should == [-65.606,40.51]
  #     end
  #     it "correctly parses '40 30.6 -65 36.36'" do
  #       latlong.to_xy("40 30.6 -65 36.36").should == [65.606,40.51]
  #     end
  #     it "correctly parses '-40 30.6 65 36.36'" do
  #       latlong.to_xy("-40 30.6 65 36.36").should == [65.606,-40.51]
  #     end
  #   end
  
end