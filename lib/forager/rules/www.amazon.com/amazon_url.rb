require 'forager/uri_helper'
require 'forager/logger_helper'

=begin
  Class that describes how to extract the next directory based on a URL.
  
  @uri_amazon_product = 'http://www.amazon.com/LEGO-Indiana-Jones-Stolen-Treasure/dp/B000WNWYH2/ref=sr_1_23?ie=UTF8&s=toys-and-games&qid=1257366894&sr=1-23'
  
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