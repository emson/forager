require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'mechanize'
require 'nokogiri'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end

describe DocumentResult do

  before(:all) do
    @uri = 'http://google.com'
    agent = WWW::Mechanize.new
    @page = agent.get(@uri)
  end
  
  it "should respond_to exception" do
    result = DocumentResult.new(@page, @uri)
    result.should respond_to :exception
  end
  
  it "should construct with a WWW::Mechanize::Page object, with no exceptions set" do
    result = DocumentResult.new(@page, @uri)
    result.has_exception.should be_false
    result.exception.should be_nil
  end
  
  it "should log exception if constructor does not recieve a WWW::Mechanize::Page object" do
    result = DocumentResult.new("STRING", @uri)
    result.has_exception.should be_true
    result.exception.should_not be_nil
    result.exception.message.should match /class WWW::Mechanize::Page/
  end
  
  
  it "should log exception when nil WWW::Mechanize::Page is passed" do
    result = DocumentResult.new(nil, @uri)
    result.has_exception.should be_true
    result.exception.should_not be_nil
    result.exception.message.should == "the page object passed was nil"
  end
  
  it "should respond_to a page method" do
    result = DocumentResult.new(@page, @uri)
    result.should respond_to(:page)
  end
  
  it "should respond_to a url method" do
    result = DocumentResult.new(@page, @uri)
    result.should respond_to(:uri)
  end
  
  it "should have the correct URI value" do
    result = DocumentResult.new(@page, @uri)
    result.uri.should == @uri
  end
  
  it "should not throw a RuntimeError if the url is invalid" do
    DocumentResult.new(@page, nil).has_exception.should be_true
  end
  
  it "should respond_to a content method" do
    result = DocumentResult.new(@page, @uri)
    result.should respond_to(:content)
  end
  
  it "should allow content to be set" do
    content = "<html></html>"
    result = DocumentResult.new(@page, @uri)
    result.content = content
    result.content.should == content
  end
  
  it "the content method should default to the page content" do
    result = DocumentResult.new(@page, @uri)
    result.content.should include('google')
  end
  
end