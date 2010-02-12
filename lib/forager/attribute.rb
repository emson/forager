
=begin

Class that wraps an attribute.
Author:  B. F. B. Emson

=end


class Attribute
  
  attr_reader :key
  
  def initialize(key)
    raise "key passed to Attribute object was nil" if key.nil?
    @key = key
  end
  
end