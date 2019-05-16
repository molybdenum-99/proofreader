require 'nokogiri'
require_relative 'proofreader/version'
require_relative 'proofreader/rules'
require 'pry'

class Proofreader
  attr_reader :rules

  def initialize
    @doc = ::Nokogiri::XML(open('./data/en/grammar.xml'))
    @rules = build_rules # Nested Element
  end

  private 

  def build_rules
    Rules.call(@doc.xpath('//rules'))
  end
end

proofreader = Proofreader.new # NOTE: In the future we can setup for 'en', but only parsing English for now
pp proofreader.rules

# MASTER TODO:
# TODO 1: Use XML Documentation to ensure all attributes are accounted for for each existing tag.
# TODO 2: Check all attributes again for ones that have a default. Some say 'off', others say 'no', etc. Should we make these boolean false? Or keep them as strings
# TODO 3: Consistency with namespacing. If a tag is only nested under a tag other than proofreader, should we namespace under it? Proofreader::Pattern::Token for example?

# XML Schema Sources:
# Everything outside of pattern: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# Pattern: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
