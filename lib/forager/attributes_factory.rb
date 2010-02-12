require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'logger'

require 'forager/attribute'
require 'forager/dir_helper'
require 'forager/logger_helper'
require 'forager/uri_helper'

=begin

Factory class that returns an Attributes container of attributes for a given url.
Author:  B. F. B. Emson

=end

class AttributesFactory
  
  include UriHelper
  include LoggerHelper
  
  attr_reader :uri, :attributes, :categoriser
  
  def initialize(uri, categoriser)
    UriHelper.validate_uri(uri)
    raise "categoriser cannot be nil" if categoriser.nil?
    @logger = LoggerHelper.logger
    @uri = uri
    @categoriser = categoriser
    @attributes ||= []
    @site_path = ''
    @rule_dir = 'rules' # TODO: put into a helper class
    construct_attributes_from_uri
  end
  
  
  private
  
  
  def construct_attributes_from_uri
    # require the categoriser file for this URI
    category = @categoriser.category_for(@uri)
    full_cat_file = @categoriser.get_category_file(category)
    require full_cat_file # Consider using ActiveSupport gem?
    
    # get the directories for this URI
    focus_dirs = get_web_site_focus(full_cat_file)
    site_keys = focus_dirs.unshift(category) # insert the category as the first element of the array
    @site_path = File.join(site_keys)
    
    # get the attributes for this URI
    site_attributes = DirHelper.get_dirs(DirHelper.category_path(@site_path))
    site_attributes.each do |attribute|
      attribute_key = File.join(@site_path, attribute)
      @logger.debug "attribute paths: #{attribute_key}"
      @attributes << Attribute.new(attribute_key)
    end
  end
  
  
  def get_web_site_focus(filename)
    klass = DirHelper.filename_to_classname(filename)
    site_url = Object.const_get(klass).new(@uri)
    site_url.focus_dirs
  end
  
  
end