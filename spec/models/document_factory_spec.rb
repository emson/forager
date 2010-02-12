
require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'nokogiri'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe DocumentFactory do

  before(:each) do
    @uri_resource = 'http://google.com'
    @factory = DocumentFactory.new
  end
  
  it "should have a fetch method" do
    @factory.should respond_to :fetch
  end
  
  it "DocumentFactory.fetch should not throw an exception if an invalid URI is entered" do
    lambda{@factory.fetch(nil)}.should_not raise_error
    lambda{@factory.fetch('htp://some.bad.uri.com')}.should_not raise_error
  end
  
  it "DocumentFactory.fetch should not fail if a bad url is passed, but result should have exception" do
   result = @factory.fetch('htp://bad.url.com')
   result.has_exception.should be_true
   result.exception.should be_instance_of(RuntimeError)
  end
  
  it "should return a DocumentResult object when fetch is called" do
    @factory.fetch(@uri_resource).should be_instance_of(DocumentResult)
  end
  
  it "will have the same uri_resource value" do
    @factory.fetch(@uri_resource)
    @factory.uri_resource.should == @uri_resource
  end

  
end
