

=begin
  Class that can extract meaningful values from a String
=end


class Extractor
  
  def initialize
    @key = ''
    @snippet = ''
    @type = ''
  end
  
  # TODO: use the TrafficBroker numb gem here
  def extract(result)
    if !result.nil? then
      init(result)
      case 
      when @type.name == "Float"
        return extract_as_currency(result)
      
      when @type.name == "String"
        return extract_as_str(result)
      end
    end
    return nil
  end
  
  # <b class="priceLarge">Â£834.98</b>
  def extract_as_currency(result)
    if !result.nil? then
      init(result)
      val = @snippet[/\d+\.*\d*/]
      return val.to_f
    end
    return nil
  end
  
  # <span id="btAsinTitle">Silver Cross Junior Ranger</span>
  def extract_as_str(result)
    if !result.nil? then
      init(result)
      val = @snippet[/>.+</].chop
      return val[1, val.size]
    end
    return nil
  end


  private 
  
  def init(result)
    # @snippet = ''
    # @type = nil
    # @key = ''
    if !result.nil? then
      @key = result.keys[0]
      shard = result[@key]
      @snippet = shard[0]
      @type = shard[1]
    end
  end
  
end