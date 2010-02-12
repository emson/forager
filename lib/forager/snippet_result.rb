
=begin
  Class that actually scrapes the page with the rules supplied.
  Author:  B. F. B. Emson
  Date:  June 2009
=end

class SnippetResult
  
  attr_accessor :attribute
  
  def initialize
    @snippets ||= {}
  end
  
  def add(key, val, type)
    @snippets[key] = [val, type]
  end
  
  def keys
    @snippets.keys
  end
  
  def each_key(&block)
    @snippets.each_key(&block)
  end
  
  def [](key)
    @snippets[key]
  end
  
end
