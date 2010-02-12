require 'rubygems'
require 'spec'
require 'spec/autorun'

# require all the scraper files
Dir[File.join(File.dirname(__FILE__), "../*.rb")].each do |file|
  require file
end


describe SnippetResult do

  before(:all) do
    @uri = 'http://www.amazon.co.uk/Canon-EOS-50D-Digital-Camera/dp/B001E97GDK/ref=sr_1_1?ie=UTF8&s=electronics&qid=1243205826&sr=8-1'
    # @doc_factory = DocumentFactory.new
    # @doc = @doc_factory.fetch(@uri)
    # @attribute = Attribute.new(File.join(%w{ www.amazon.co.uk product price }))
    # @factory = RulesFactory.new
    @snippet_result = SnippetResult.new
  end
  
  it "should respond_to attribute" do
    @snippet_result.should respond_to :attribute
  end
  
  it "should respond_to add" do
    @snippet_result.should respond_to :add
  end
  
  it "should respond_to keys" do
    @snippet_result.should respond_to :keys
  end
  
  it "should respond_to each_key" do
    @snippet_result.should respond_to :each_key
  end
  
  it "should respond_to [add]]" do
    @snippet_result.should respond_to :[]
  end
  
  # it "should respond_to snippets" do
  #   @snippet_result.should respond_to :snippets
  #   @snippet_result.snippets.should be_an_instance_of(Hash)
  # end
  
  # it "should respond_to rules, which lists rules this SnippetResult object uses" do
  #   @snippet_result.should respond_to :rules
  #   @snippet_result.rules.should be_an_instance_of(Array)
  # end
  
  # it "should respond_to has_snippet_for?" do
  #   @snippet_result.should respond_to :has_snippets_for?
  # end
  
  # it "should return false if has_snippets_for? is nil or doesn't exist" do
  #    @snippet_result.has_snippets_for?(nil).should be_false
  #    @snippet_result.has_snippets_for?('saussage').should be_false
  # end
  
  # it "should return a price snippet" do
  #   snippets = @snippet_result.snippets
  #   snippets['AmazonProductPriceRule1'].should match /priceLarge/
  # end
  
end







