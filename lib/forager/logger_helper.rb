require "logger"

module LoggerHelper
  
  
  def LoggerHelper.level
    Logger::DEBUG
  end
  
  def LoggerHelper.output
    STDOUT
  end
  
  @logger = nil
  
  def LoggerHelper.logger
    @logger = ForagerLogger.new if @logger.nil?
    @logger
  end
  
  def LoggerHelper.logger=(logger)
    raise "you can not set a nil logger" if logger.nil?
    @logger = logger
  end
  
  
  class ForagerLogger < Logger
    
    attr_reader :is_ignore
    
    def initialize(log_level=LoggerHelper.level, output=LoggerHelper.output, ignore=true)
      super(output)
      @level = log_level
      @is_ignore = ignore
    end
    
    def is_ignore(val)
      @is_ignore = (val == true) ? true : false
    end
    
    def debug(progname=nil, &block)
      unless @is_ignore then
        super(progname, &block)
      end
    end
    
    
    def info(progname=nil, &block)
      unless @is_ignore then
        super(progname, &block)
      end
    end
    
    def error(progname=nil, &block)
      unless @is_ignore then
        super(progname, &block)
      end
    end
    
     # error
     # fatal
     # info
     # log
     # unknown
     # warn
    
  end
  

  
end