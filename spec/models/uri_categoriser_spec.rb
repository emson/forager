require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe UriCategoriser do

  before(:each) do
    @uri_cat_test = "http://some.test-category.co.uk/product/item&colour=red"
    @uri = 'http://www.amazon.co.uk/Canon-EOS-50D-Digital-Camera/dp/B001E97GDK/ref=sr_1_1?ie=UTF8&s=electronics&qid=1243205826&sr=8-1'
    @categoriser = UriCategoriser.new
  end
  
  it "should respond_to a category_for method" do
    @categoriser.should respond_to :category_for
  end
  
  it "should return the correct category (domain) for a URI" do
    @categoriser.category_for(@uri).should == "www.amazon.co.uk"
  end
  
  it "should make a number of attempts to find the right category" do
    @categoriser.category_for(@uri_cat_test).should == 'test-category'
  end
  
  it "should respond_to get_category_file" do
    @categoriser.should respond_to :get_category_file
  end
  
  it "should return the correct path to the category file" do
    category = @categoriser.category_for(@uri)
    @categoriser.get_category_file(category).should match /amazon_url/
  end
  
end