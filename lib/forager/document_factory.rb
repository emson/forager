require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'logger'

require 'forager/uri_helper'
require 'forager/logger_helper'
require 'forager/tracker'

=begin

Factory class that fetches a web page and returns a Document object.
Author:  B. F. B. Emson

=end

class DocumentFactory
  
  include UriHelper
  include LoggerHelper
  
  attr_reader :uri_resource
  
  def initialize()
    @logger = LoggerHelper.logger
    @logger.debug('Initializing DocumentFactory...')
  end
  
  
  def fetch(uri, agent=WWW::Mechanize.new)
    @uri_resource = uri
    begin
      @logger.debug("fetching: #{@uri_resource}; with agent: #{agent}")
      UriHelper.validate_uri(@uri_resource)
      page = agent.get(@uri_resource)
      return DocumentResult.new(page, @uri_resource)
      
    rescue Exception => e
      @logger.error(e)
      return DocumentResult.new(nil, @uri_resource, e)
    end
  end
  

end


