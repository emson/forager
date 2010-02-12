
require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe RulesFactory do

  before(:all) do
    @attribute_price = Attribute.new(File.join("www.amazon.co.uk", "product", "price"))
    @factory = RulesFactory.new
  end
  
  it "should raise error if setting an invalid attributes object" do
    lambda{ @factory.rules_for nil }.should raise_error
    lambda{ @factory.rules_for "A STRING CLASS" }.should raise_error
  end
  
  it "should respond_to rules_for" do
    @factory.should respond_to :rules_for
  end
  
  it "should return an array of RuleX objects when rules_for is called" do
    array = @factory.rules_for @attribute_price
    array.should be_a_instance_of(Array)
    array[0].class.name.should match(/Rule/)
  end

  
end