# Main loader file, load all the ruby files so that they can be referenced by other apps.

# Add this file to the load path if it doesn't already exist.
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# require all the rb files in the forager dir
Dir[File.join(File.dirname(__FILE__), "forager/*.rb")].each do |file|
  require file
end

module Forager
  VERSION = '0.0.6'
end