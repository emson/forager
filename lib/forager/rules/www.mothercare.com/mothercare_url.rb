require 'forager/uri_helper'
require 'forager/logger_helper'

=begin
  Class that describes how to extract the next directory based on a URL.
  
  @uri_mothercare_list = ''
  @uri_mothercare_product = 'http://www.mothercare.com/Quinny-Buzz-4-wheeler-Midnight-blue/dp/B0012ET7TS/sr=1-1/qid=1252406585/ref=sr_1_1/277-7415945-6926533?%5Fencoding=UTF8&m=A2LBKNDJ2KZUGQ&n=42764041&mcb=core'
  
=end

class MothercareUrl
  
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
    when /\/gp\//
      @focus_dirs << 'list'
    when /\/dp\//
      @focus_dirs << 'product'
      
    else
      class_name = self.class.name
      error_message = "the class #{class_name} is parsing uri: #{@uri}, and cannot find an appropriate category!\n"
      @logger.error(error_message)
      raise error_message
    end
    
  end
  
end