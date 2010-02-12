require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe Scraper do

  before(:each) do
    @uri = 'http://www.amazon.co.uk/Canon-EOS-50D-Digital-Camera/dp/B001E97GDK/ref=sr_1_1?ie=UTF8&s=electronics&qid=1243205826&sr=8-1'
    @scraper = Scraper.new
  end
  
  it "should have a scrape method" do
    @scraper.should respond_to :scrape
  end
  
  it "should raise an error if an invalid URL is passed for scraping" do
    lambda{ @scraper.scrape(nil) }.should raise_error
    lambda{ @scraper.scrape('htp://bad.url.com') }.should raise_error
  end
  
  it "should return a SnippetsContainer when scrape is called" do
    container = @scraper.scrape(@uri)
    container.should be_an_instance_of(SnippetsContainer)
  end
  
  
  it "should respond_to a get_document method" do
    @scraper.should respond_to :get_document
  end
  
end