require 'forager/dir_helper'
require 'forager/logger_helper'
require 'forager/uri_helper'

=begin
  Class that analyses a URI and determines the domain and the attribute directories.
  Author:  B. F. B. Emson
  Date:  June 2009
=end

class UriCategoriser
  
  # Returns the category (directory) for a given URI
  # It will try a number of attempts to get the category,
  # this is because you could have sites with www.amazon.co.uk or amazon.co.uk,
  # i.e. some sites may or may not have a subdomain and this may or may not be significant.
  def category_for(uri)
    UriHelper.validate_uri(uri)
    host = UriHelper.host_from(uri)
    return host if DirHelper.has_category?(host)
    
    domain = UriHelper.domain_from(uri)
    return domain if DirHelper.has_category?(domain)
    
    short_domain = UriHelper.short_domain_from(uri)
    return short_domain if DirHelper.has_category?(short_domain)
    
    raise "could not find a category for this URI: #{uri}"
  end
  
  # returns the full path to the category file for this category.
  # NB: there should be one and only one category file per category.
  def get_category_file(category)
    category_file_path = DirHelper.category_path(category)
    category_files = DirHelper.get_files(category_file_path, '.rb')
    LoggerHelper.logger.info("there is more than one category file (#{category_files.join(', ')}) in this category: #{category}") if category_files.size > 1
    category_file = category_files[0] # assumes there will be only one category file per category
    raise "there is no category file for this category: #{category}" if category_file.nil?
    return File.join(category_file_path, category_file)
  end
  
end