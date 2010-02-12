require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe Extractor do

  before(:each) do
    @extractor = Extractor.new
  end
  
  it "should have a extract method" do
    @extractor.should respond_to :extract
  end
  
  it "should correctly extract the price from: <b class=\"priceLarge\">Â£834.98</b>" do
    result = SnippetResult.new
    result.attribute = 'www.amazon.co.uk/product/price'
    result.add('AmazonProductPriceRule1', '<b class="priceLarge">Â£834.98</b>', Float)
    @extractor.extract(result).should == 834.98
  end
  
  
  it "should correctly extract the title from: <span id=\"btAsinTitle\">Silver Cross Junior Ranger</span>" do
    result = SnippetResult.new
    result.attribute = 'www.amazon.co.uk/product/title'
    result.add('AmazonProductTitleRule1', '<span id="btAsinTitle">Silver Cross Junior Ranger</span>', String)
    @extractor.extract(result).should == "Silver Cross Junior Ranger"
  end
  
  
  it "should return nil if a nil result object is passed to be extracted" do
    @extractor.extract(nil).should be_nil
  end
  
  it "should respond_to a extract_as_currency method" do
    @extractor.should respond_to :extract_as_currency
  end
  
  it "should return nil if a nil result object is passed to extract_as_currency" do
    @extractor.extract_as_currency(nil).should be_nil
  end
  
  it "should respond_to a extract_as_str method" do
    @extractor.should respond_to :extract_as_str
  end
  
  it "should return nil if a nil result object is passed to extract_as_str" do
    @extractor.extract_as_str(nil).should be_nil
  end
  
end