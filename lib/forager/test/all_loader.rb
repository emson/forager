

class AllLoader
  
  attr_reader :pages
  
  # Add any new files and their URIs here
  def load_all
    load "bambinodirect_product_cameleon.html", "http://www.bambinodirect.co.uk/details2.asp/ProductID/1629/sid//bugaboo-cameleon.html"
    load "amazon_product_book1.html", "http://www.amazon.co.uk/gp/product/1845296435/ref=s9_wsds_gw_ir01?pf_rd_m=A3P5ROKL5A1OLE&pf_rd_s=center-7&pf_rd_r=0FKFBGQ5ZT0H901VR3B4&pf_rd_t=101&pf_rd_p=467128273&pf_rd_i=468294"
    load "amazon_product_pram1.html", "http://www.amazon.co.uk/X-Adventure-Crossover-Pushchair-carry-combination/dp/B0011OFD42/ref=sr_1_17?ie=UTF8&s=baby&qid=1244637674&sr=8-17"
  end
  
  def initialize()
    @pages ||= {}
    load_all
    validate
  end
  
  def load(filename, uri)
    @pages[filename] = uri
  end
  
  def [](key)
    return @pages[key]
  end
  
  def keys
    @pages.keys
  end
  
  private 
  
  def validate
    files = DirHelper.get_files(File.dirname(__FILE__), '.html', true)
    puts "WARNING: there are HTML files in the 'test' directory that have not been loaded in the 'load_all' method" if @pages.size < files.size
    puts "WARNING: there are more loaded files than HTML files in the test directory, this suggests duplicates" if @pages.size > files.size
  end
  
end