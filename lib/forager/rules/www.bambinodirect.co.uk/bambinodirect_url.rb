require 'forager/uri_helper'
require 'forager/logger_helper'

=begin
  Class that describes how to extract the next directory based on a URL.
  
  @uri_bambinodirect_list = ''
  @uri_bambinodirect_product = 'http://www.bambinodirect.co.uk/details2.asp/ProductID/1629/sid//bugaboo-cameleon.html'
  
=end

class BambinodirectUrl
  
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
    when /\/products\.asp\//
      @focus_dirs << 'list'
    when /\/ProductID\//
      @focus_dirs << 'product'
      
    else
      class_name = self.class.name
      error_message = "the class #{class_name} is parsing uri: #{@uri}, and cannot find an appropriate category!\n"
      @logger.error(error_message)
      raise error_message
    end
    
  end
  
end