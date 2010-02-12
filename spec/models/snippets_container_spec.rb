require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe SnippetsContainer do

  before(:each) do
    @container = SnippetsContainer.new
  end

  it "should respond_to add" do
    @container.should respond_to :add
  end
  
  it "should respond_to container" do
    @container.should respond_to :container
  end
  
  it "should respond_to size" do
    @container.should respond_to :size
  end
  
  it "should respond_to each_key" do
    @container.should respond_to :each_key
  end
  
  it "should return a hash when container is called" do
    @container.container.should be_an_instance_of(Hash)
  end
  
  it "should only add valid snippets objects" do
    lambda{ @container.add(nil) }.should raise_error
    lambda{ @container.add("NOT A SNIPPETRESULT") }.should raise_error
  end
  
  
end