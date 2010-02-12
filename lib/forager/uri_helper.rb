
require 'uri'


module UriHelper
  
  
  def UriHelper.host_from(uri)
    if !uri.nil? && uri !~ /^http/ then uri = 'http://' + uri end # add http part if it is missing
    if !uri.nil? && UriHelper.is_valid_uri?(uri) then
      uri = URI.parse(uri)
      return uri.host
    end
    return nil
  end
  
  
  def UriHelper.domain_from(uri)
    host = UriHelper.host_from(uri)
    if !host.nil?
      shards = host.split('.')
      last_index = shards.size - 1
      start_index = last_index - 1
      dot_tlds = %w{ co me org ltd com} # possible other tlds to ignore
      dot_tlds.each { |tld| start_index = last_index - 2 if tld == shards[start_index] } # remove the tlds to ignore
      domain = shards[start_index, shards.size]
      return domain.join('.').downcase
    end
    return nil
  end
  
  
  def UriHelper.short_domain_from(uri)
    if !uri.nil? && uri !~ /^http/ then uri = 'http://' + uri end # add http part if it is missing
    if !uri.nil? && UriHelper.is_valid_uri?(uri) then
      uri = URI.parse(uri)
      host = uri.host
      shards = host.split('.')
      shards = shards[0, shards.size-1] # remove the last element as it will never be the domain
      last = shards.last
      dot_tlds = %w{ co me org ltd com} # possible other tlds to ignore
      dot_tlds.each { |tld| last = shards[0, shards.size-1].last if tld == last } # remove the tlds to ignore
      last.downcase!
      return last
    end
    return nil
  end
  
  
  def UriHelper.is_valid_uri?(uri)
    if !uri.nil? && uri =~ /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix then
      return true
    else
      return false
    end
  end
  
  
  def UriHelper.validate_uri(uri)
    raise "the URI Resource can not be nil" if uri.nil?
    raise "the URI resource: '#{uri}', is invalid" unless UriHelper.is_valid_uri?(uri)
  end
  
end


if __FILE__ == $0 then
  # puts UriHelper::short_domain_from('emson.ltd.co')
  # puts UriHelper::is_valid_uri?('http://www.emson.co/?&npadf/asdf/zdfg/ert/fvb/serg/dfg/dafg.htmlllll')
  
  # puts UriHelper::domain_from('emson.ltd.co')
  # puts UriHelper::domain_from('www.emson.ltd.uk')
  # puts UriHelper::domain_from('www.blog.emson.com')
  # puts UriHelper::domain_from('www.blog.emson.ltd.com')
  
  # puts UriHelper::domain_from('emson.ltd.uk')
end