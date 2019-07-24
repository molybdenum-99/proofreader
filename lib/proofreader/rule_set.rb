require_relative 'rule_set/rules'
require 'nokogiri'
require_relative '../proofreader' #TODO: Add absolute reference

class Proofreader
  class RuleSet
    attr_reader :rules

    def initialize(xml: , rules: nil)
      @xml = xml
      @rules = rules
    end

    def read
      @rules = RuleSet::Rules.array_from_xml(@xml.xpath('rules'))
    end
  end
end