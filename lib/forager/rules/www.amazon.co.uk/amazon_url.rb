require 'forager/uri_helper'
require 'forager/logger_helper'

=begin
  Class that describes how to extract the next directory based on a URL.
  
  @uri_amazon_list = 'http://www.amazon.co.uk/Deals-Week/b/ref=cs_top_nav_gb27?ie=UTF8&node=350613011'
  @uri_amazon_product = 'http://www.amazon.co.uk/Canon-EOS-50D-Digital-Camera/dp/B001E97GDK/ref=sr_1_1?ie=UTF8&s=electronics&qid=1243205826&sr=8-1'
  
=end

class AmazonUrl
  
  attr_reader :uri, :focus_dirs
  
  def initialize(uri)
    UriHelper.validate_uri(uri)
    @uri = uri
    @logger = LoggerHelper.logger
    @focus_dirs ||= []
    handle_uri
  end
  
  private
  
  def handle_uri
    case @uri
    when /\/b\//
      @focus_dirs << 'list'
    when /\/dp|gp\//
      @focus_dirs << 'product'
      
    else
      class_name = self.class.name
      error_message = "the class #{class_name} is parsing uri: #{@uri}, and cannot find an appropriate category!\n"
      @logger.error(error_message)
      raise error_message
    end
    
  end
  
end