require 'rubygems'

require 'forager/attribute'
require 'forager/dir_helper'
require 'forager/logger_helper'

=begin

Factory class that returns all the rules for a particular Attribute.
Author:  B. F. B. Emson

=end

class RulesFactory
  
  def initialize()
    @logger = LoggerHelper.logger
    # @rules_dir = DirHelper::RULES_DIR
    # @rules_dir = 'rules'
  end
  
  
  def rules_for(attribute)
    raise "the attribute parameter should not be nil" if attribute.nil?
    raise "the parameter passed is not of type Attribute" unless attribute.instance_of?(Attribute)
    rule_dir = DirHelper.category_path(attribute.key)
    rule_names = DirHelper.get_files(rule_dir, '.rb')
    require_rules(rule_dir, rule_names)
    rules_as_objects(rule_names)
  end
  
  
  private
  
  
  def rules_as_objects(rules)
    rule_objs ||= []
    rules.each do |rule|
      klass = DirHelper.filename_to_classname(rule)
      obj = Object.const_get(klass).new
      validate(obj)
      rule_objs << obj
    end
    rule_objs
  end
  
  def require_rules(dir, rule_files)
    rule_files.each do |file| 
      require File.join(dir, file)
    end
  end
  
  def validate(rule)
    raise "the rule #{rule.class.name}, does not have a 'parse' method" unless rule.respond_to? :parse
    raise "the rule #{rule.class.name}, does not have a 'as_type_of' method" unless rule.respond_to? :as_type_of
  end
  
end


