
require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'nokogiri'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe Attribute do

  before(:each) do
    @key_as_array = %w{ alpha beta gamma }
    @key_as_path = File.join(@key_as_array)
    @attribute = Attribute.new(@key_as_path)
  end
  
  it "should have a key method" do
    @attribute.should respond_to :key
  end
  
  it "should return the correct key when the method is called" do
    @attribute.key.should == @key_as_path
  end
  
  it "should fail if the key is nil" do
    lambda{ Attribute.new nil }.should raise_error
  end
  
end