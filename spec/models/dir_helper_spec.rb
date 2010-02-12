require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end

describe DirHelper do

  before(:all) do
    @test_category = 'test-category'
    @test_category_path = DirHelper.category_path(@test_category)
  end
  
  it "should return true if the category directory exists with has_category?" do
    DirHelper.has_category?(@test_category).should be_true
  end
  
  it "should return false if the category directory doesn't exist with has_category?" do
    DirHelper.has_category?("sausage").should be_false
  end
  
  it "should get a full category path" do
    DirHelper.category_path(@test_category).should == './spec/models/../../lib/forager/rules/test-category'
  end
  
  it "with DirHelper.get_dirs return a valid list of directories" do
    dirs = DirHelper.get_dirs(@test_category_path)
    dirs.size.should == 2
    dirs.should include('test1')
  end
  
  it "should return all the files in a directory" do
    files = DirHelper.get_files(@test_category_path, '.rb')
    files.size.should == 1
    files[0].should == 'test_category_url'
  end
  
  it "should be able to create an object name from a filename" do
    name = DirHelper.filename_to_classname("test_category_url.rb")
    name.should == "TestCategoryUrl" 
  end
  
end