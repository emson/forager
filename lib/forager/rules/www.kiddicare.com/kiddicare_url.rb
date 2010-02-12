require 'forager/uri_helper'
require 'forager/logger_helper'

=begin
  Class that describes how to extract the next directory based on a URL.
  
  @uri_kiddicare_list = 'http://www.kiddicare.com/webapp/wcs/stores/servlet/categorydisplay10A_37_10751_14552_-1__14051_14051_10001_14051'
  @uri_kiddicare_product = 'http://www.kiddicare.com/webapp/wcs/stores/servlet/productdisplayA_0_10751_-1__73015_10001_'
  
=end

class KiddicareUrl
  
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
    when /\/categorydisplay/
      @focus_dirs << 'list'
    when /\/productdisplay/
      @focus_dirs << 'product'
      
    else
      class_name = self.class.name
      error_message = "the class #{class_name} is parsing uri: #{@uri}, and cannot find an appropriate category!\n"
      @logger.error(error_message)
      raise error_message
    end
    
  end
  
end