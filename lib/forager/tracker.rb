
require 'logger'

=begin
  Class that tracks all the scraping activity.  This will be used for reporting on 
  how a URI was scraped what errors were encountered, etc.
=end

class Tracker
  
  attr_reader :has_exception, :exception, :records
  attr_accessor :for_test
  
  def initialize(log_level=Logger::ERROR, output=STDOUT, for_test=false)
    @for_test = for_test
    @has_exception = false
    @log = Logger.new(output)
    @log.level = log_level
    self.debug('Initializing tracker...')
  end
  
  def error(exception, class_name=nil, note=nil)
    raise "the exception object passed was nil" if exception.nil?
    exception = set_as_exception(exception)
    @exception = exception
    @has_exception = true
    class_message = (class_name.nil?) ? '' : " Class: #{class_name};"
    note_message = (class_name.nil?) ? '' : " Note: #{note}"
    @log.error("Exception: #{exception.message}\n #{exception.backtrace.join("\n")};#{class_message}#{note_message}") unless @for_test
  end
  
  def debug(message)
    klass = "TODO"
    name = ""
    name = klass unless klass.nil?
    @log.debug("class: <#{name}> #{message}") unless @for_test
  end
  
  
  def record(message)
    @records << message
  end
  
  private
  
  def set_as_exception(message)
    message = RuntimeError.new(message) if message.instance_of?(String)
    message
  end
  
end