
require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'nokogiri'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe AttributesFactory do
  
  include LoggerHelper
  
  before(:all) do
    @uri_amazon_list = 'http://www.amazon.co.uk/Deals-Week/b/ref=cs_top_nav_gb27?ie=UTF8&node=350613011'
    @uri_amazon_product = 'http://www.amazon.co.uk/Canon-EOS-50D-Digital-Camera/dp/B001E97GDK/ref=sr_1_1?ie=UTF8&s=electronics&qid=1243205826&sr=8-1'
    @categoriser = UriCategoriser.new
    @factory = AttributesFactory.new(@uri_amazon_product, @categoriser)
  end
  
  it "should have an attributes method" do
    @factory.should respond_to :attributes
  end
  
  it "initialize should take a valid URL" do
    lambda{AttributesFactory.new(nil, @categoriser)}.should raise_error
    lambda{AttributesFactory.new('htp://not.valid.com', @categoriser)}.should raise_error
  end
  
  it "should raise error if categoriser is nil" do
    lambda{AttributesFactory.new(@uri_amazon_product, nil)}.should raise_error
  end
  
  it "attributes method should return an Array" do
    @factory.attributes.should be_a_kind_of(Array)
  end
  
  
  it "should return correct attribute objects when attributes is called against a URI" do
    attributes = @factory.attributes
    # How to check that an array includes all elements
    attributes.should have(4).things
    attributes[0].should be_a_kind_of(Attribute)
  end
  

  
end
