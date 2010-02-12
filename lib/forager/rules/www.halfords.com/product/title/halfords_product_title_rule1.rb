require 'rubygems'
require 'nokogiri'

=begin
  Class that describes a rule.
  NB: you cannot use modules as namespaces as it is tricky and expensive to instantiate them.
  By B. F. B. Emson Esq.
  May 2009
=end

class HalfordsProductTitleRule1

  def parse(doc_result)
    raise "the DocumentResult object passed to #{self.class.name} is nil" if doc_result.nil?
    raise "expected the doc object to be a DocumentResult instance, but was #{doc_result.class.name}" unless doc_result.kind_of?(DocumentResult)
    page = Nokogiri::HTML(doc_result.content)
    title = page.css('h1.title')
    badspan = title.css('#itemscode').to_s
    title = title.to_s.gsub(badspan, "")
    title = title.to_s.gsub("\t", "")
    title = title.to_s.gsub("\n", "")
    stuff = Nokogiri::HTML(title)
    puts "***#{title.to_s}"
    return title.to_s
  end
  
  def as_type_of
    String
  end
end
