require 'nokogiri'
require 'pry'
require_relative 'antipattern'
require_relative 'pattern'
require_relative 'message'
require_relative 'example'

class Proofreader
  class Rule
    def initialize(**options)
      @id = options[:id]
      @name = options[:name]
      @category = options[:category]
      @rulegroup = options[:rulegroup]
      @antipatterns = Antipattern.new(options[:antipatterns])
      @patterns = Pattern.new(options[:patterns])
      @filter = options[:filter] # NOTE: May need to be a class; LanguageTool uses this with dates.
      @regexp = options[:regexp] # NOTE: Will need to be a class
      @message = Message.new(options[:message])
      @url = options[:url].text
      @short = options[:short]
      @examples = Example.new(options[:examples])
    end
  end

  # def analyze
    # NOTE: Logic for actually checking string against the rule
  # end
end