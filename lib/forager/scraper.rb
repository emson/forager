
# load all the files in the current dir
Dir[File.join(File.dirname(__FILE__), "*.rb")].each do |file|
  require file
end


class Scraper
  
  attr_reader :uri
  
  def initialize()
    @logger = LoggerHelper.logger
  end
  
  #TODO: add tracking here
  def get_document(uri, test_content=nil)
    @uri = uri
    UriHelper.validate_uri(@uri)
    factory = DocumentFactory.new
    
    if test_content.nil? then
      return factory.fetch(@uri)
    else
      puts "- by passing internet -"
      doc = DocumentResult.new(nil, @uri, nil)
      doc.content = test_content
      return doc
    end
  end
  
  
  # TODO: refactor so that it doesn't care about test_content
  def scrape(uri, test_content=nil)
    begin
      doc = get_document(uri, test_content)
      
      container = SnippetsContainer.new
      rules_factory = RulesFactory.new
      
      attributes_factory = AttributesFactory.new(@uri, UriCategoriser.new)
      
      attributes_factory.attributes.each do |attribute|
        result = scrape_page(rules_factory, attribute, doc)
        # only add result if is valid (i.e. no error has occured, and messed up the result object)
        container.add(result) if !result.nil? && result.instance_of?(SnippetResult)
      end
      return container
      
    rescue Exception => e
      # TODO: add tracker here
      @logger.error(e)
      raise e
    end
  end
  
  private
  
  def scrape_page(rules_factory, attribute, doc_result)
    # get all the rule objects for this attribute
    rule_objs = rules_factory.rules_for(attribute)
    begin
      result = SnippetResult.new
      result.attribute = attribute
      # use each rule to parse the page
      rule_objs.each do |rule|
        rule_key = rule.class.name
        # parse the page html
        html_snippet = rule.parse(doc_result)
        html_type = rule.as_type_of
        LoggerHelper.logger.debug("snippet rule_name: #{rule_key}, html_snippet: #{html_snippet}, html_type: #{html_type}")
        result.add(rule_key, html_snippet, html_type)
      end
      return result
      
    rescue Exception => e
      @logger.error(e)
      return nil
    end
  end
  
  
end
