require 'forager/uri_helper'
require 'forager/logger_helper'

=begin
  Class that describes how to extract the next directory based on a URL.
  
  @uri_halfords_list = 'http://www.halfords.com/webapp/wcs/stores/servlet/categorydisplay_storeId_10001_catalogId_10151_categoryId_165461_langId_-1'
  @uri_halfords_product = 'http://www.halfords.com/webapp/wcs/stores/servlet/product_storeId_10001_catalogId_10151_productId_501433_langId_-1_categoryId_165461?cm_mmc=AffiliateWindow-_-94369-_-n%2fa-_-n%2fa&awc=1672_1252408341_feb21e055189aef6516c88584f844195'
  
=end

class HalfordsUrl
  
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
    when /\/product_store/
      @focus_dirs << 'product'
      
    else
      class_name = self.class.name
      error_message = "the class #{class_name} is parsing uri: #{@uri}, and cannot find an appropriate category!\n"
      @logger.error(error_message)
      raise error_message
    end
    
  end
  
end