

=begin
  Class that provides a container for snippet objects.  
  Adding useful methods for retrieving and managing snippets.
  by B. F. B. Emson Esq. 28th May 2009
=end

class SnippetsContainer
  
  attr_reader :container
  
  def initialize()
    @container ||= {}
  end
  
  def add(snippet)
    raise "the SnippetResult object being added was nil" if snippet.nil?
    raise "the object being added was not a SnippetResult object, but was: #{snippet.class.name}" unless snippet.instance_of?(SnippetResult)
    @container[snippet.attribute.key] = snippet
  end
  
  def [](value)
    @container[value]
  end
  
  def size
    @container.size
  end
  
  def each_key(&block)
    @container.each_key(&block)
  end
  
end