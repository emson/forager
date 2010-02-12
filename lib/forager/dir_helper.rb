
module DirHelper
  
  @@rules_dir = "rules"
  
  def DirHelper.has_category?(category)
    return false if category.nil?
    has_dir = File.directory?(File.join(File.dirname(__FILE__), @@rules_dir, category))
    return has_dir
  end
  
  def DirHelper.category_path(category)
    raise "the DirHelper.category_path for category: #{category} is invalid" unless DirHelper.has_category?(category)
    return File.join(File.dirname(__FILE__), @@rules_dir, category)
  end
  
  def DirHelper.get_dirs(dir)
    my_dir = Dir.new(dir)
    dirs = []
    # remember that this lists directories as String and not Dir types
    my_dir.each do |d| 
      dirs << d if File.directory?(File.join(dir, d)) && d != '.' && d != '..'
    end
    dirs
  end
  
  def DirHelper.get_files(dir, ext, is_show_ext=false)
    files = []
    my_dir = Dir.new(dir)
    # get all items in the directory, files and directories
    my_dir.each do |f| 
      file_name = f
      file_name = File.basename(f, ext) unless is_show_ext # remove the extension of files that match the ext extension
      afile = File.join(dir, f)
      files << file_name if File.file?(afile) && File.extname(afile) == ext
    end
    files
  end
  
  def DirHelper.filename_to_classname(filename)
    return filename if filename.nil?
    filename = File.basename(filename, File.extname(filename))
    shards = filename.split('_')
    name = shards.map { |x| x.capitalize! }.join('')
    return name
  end
  
end