
require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe Tracker do

  before(:each) do
    @tracker = Tracker.new(Logger::ERROR, STDOUT, true)
  end
  
  it "should have an error method" do
    @tracker.should respond_to :error
  end
  
  it "should respond_to debug" do
    @tracker.should respond_to :debug
  end
  
  it "should respond_to has_exception" do
    @tracker.should respond_to :has_exception
  end
  
  it "should respond_to exception" do
    @tracker.should respond_to :exception
  end
  
  it "should respond_to for_test" do
    @tracker.should respond_to :for_test
  end
  
  it "should respond_to record" do
    @tracker.should respond_to :record
  end
  
  it "should respond_to records" do
    @tracker.should respond_to :records
  end
  
  it "should return an exception when a RuntimeError is passed" do
    exception = RuntimeError.new('SIMPLE RUNTIME ERROR')
    @tracker.error(exception)
    @tracker.exception.should be_a_kind_of(RuntimeError)
    @tracker.has_exception.should be_true
  end
  
  it "should return an exception even if set with a string" do
    @tracker.error("TEST EXCEPTION")
    @tracker.exception.should be_a_kind_of(RuntimeError)
    @tracker.has_exception.should be_true
  end
  
end