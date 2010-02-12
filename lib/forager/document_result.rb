require 'rubygems'
require 'mechanize'
require 'www/mechanize/page'
require 'nokogiri'
require 'logger'

require 'forager/uri_helper'
require 'forager/logger_helper'

=begin

Class that wraps a retrieved document from a URI.
Contains all the status and exception information, along with the actual document object.
Author:  B. F. B. Emson

=end

#TODO: refactor so that it doesn't care about test content, make super class

class DocumentResult
  
  include UriHelper
  include LoggerHelper
  
  attr_reader :page, :has_exception, :exception, :uri, :content
  
  def initialize(page, uri, exception=nil)
    @logger = LoggerHelper.logger
    @has_exception = false
    set_exception(exception)
    set_page(page)
    set_uri(uri)
  end
  
  # used for testing
  def content=(val)
    @exception = nil
    @has_exception = false
    @content = val
  end
  
  private 
  
  def set_uri(uri)
    if !UriHelper.is_valid_uri?(uri) then
      @has_exception = true
    else
      @uri = uri
    end
  end
  
  def set_exception(exception)
    @exception = exception
    @has_exception = true if !exception.nil?
  end
  
  def set_page(page)
    if !page.nil? then
      begin
        raise "the page should be of class WWW::Mechanize::Page" unless page.kind_of?(WWW::Mechanize::Page)
        @page = page
        @content = page.body
        
      rescue Exception => e
        @logger.error(e)
        set_exception(e)
      end
    else 
      set_exception(RuntimeError.new("the page object passed was nil"))
    end
  end
  
end