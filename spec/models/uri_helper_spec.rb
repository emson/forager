require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end

describe UriHelper do

  before(:all) do
    @uri = 'http://google.com'
  end
  
  it "should return the raw domain name without any TLDs" do
    UriHelper.short_domain_from('http://blog.emson.co.uk').should == 'emson'
    UriHelper.short_domain_from('http://www.yahoo.com').should == 'yahoo'
    UriHelper.short_domain_from('http://emson.ltd.uk').should == 'emson'
    UriHelper.short_domain_from('http://google.com').should == 'google'
    UriHelper.short_domain_from('http://www.lonebiker.net').should == 'lonebiker'
  end
  
  it "should return the domain name with TLDs" do
    UriHelper.domain_from('http://blog.emson.co.uk').should == 'emson.co.uk'
    UriHelper.domain_from('http://www.yahoo.com').should == 'yahoo.com'
    UriHelper.domain_from('http://emson.ltd.uk').should == 'emson.ltd.uk'
    UriHelper.domain_from('http://google.com').should == 'google.com'
    UriHelper.domain_from('http://www.lonebiker.net').should == 'lonebiker.net'
  end
  
  it "should return the full host name" do
    UriHelper.host_from('http://blog.emson.co.uk').should == 'blog.emson.co.uk'
    UriHelper.host_from('http://www.yahoo.com').should == 'www.yahoo.com'
    UriHelper.host_from('http://emson.ltd.uk').should == 'emson.ltd.uk'
    UriHelper.host_from('http://google.com').should == 'google.com'
    UriHelper.host_from('http://www.lonebiker.net').should == 'www.lonebiker.net'
  end
  
  it "should return nil if not a valid url, for short_domain_from" do
    UriHelper.short_domain_from(nil).should be_nil
    UriHelper.short_domain_from('something').should be_nil
  end

  it "should return nil if not a valid url, for domain_from" do
    UriHelper.domain_from(nil).should be_nil
    UriHelper.domain_from('something').should be_nil
  end
  
  it "should return nil if not a valid url, for host_from" do
    UriHelper.host_from(nil).should be_nil
    UriHelper.host_from('something').should be_nil
  end
  
  it "should return the raw domain name without any TLDs, even if the protocol is missing" do
    UriHelper.short_domain_from('blog.emson.co.uk').should == 'emson'
  end
  
  it "should return the domain name, even if the protocol is missing" do
    UriHelper.domain_from('blog.emson.co.uk').should == 'emson.co.uk'
  end
  
  it "should return the full host name, even if the protocol is missing" do
    UriHelper.host_from('blog.emson.co.uk').should == 'blog.emson.co.uk'
  end

  it "should return true if uri is valid" do
    UriHelper.is_valid_uri?('http://blog.emson.co.uk')
  end

  it "should return true if uri uses the https protocol" do
    UriHelper.is_valid_uri?('https://blog.emson.co.uk')
  end
  
  it "should be false if nil is passed" do
    UriHelper.is_valid_uri?(nil).should be_false
  end
  
  it "should raise an error if validate_uri is called on an invalid uri" do
    lambda{ UriHelper.validate_uri(nil) }.should raise_error
    lambda{ UriHelper.validate_uri('not.valid.uri') }.should raise_error
  end
  
end